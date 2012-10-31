-- * 入力ファイル
-- * ユーザ単位でグルーピング
-- * ユーザごとに
--   * 対象外データ除外
--   * 抽出条件でフィルタリング
-- * 結果項目を出力


-- * 入力ファイル
--   * 会員
--   * お気入りリスト
--   * 購入履歴

member = LOAD 'data/member' AS (
	mid:chararray,
	age:int,
	rank:chararray,
	act_date:chararray,
	del_flag:chararray);

fav_list = LOAD 'data/fav_list' AS (
	mid:chararray,
	reg_date:chararray,
	prod_no:chararray);

purch_hist = LOAD 'data/purch_hist' AS (
	mid:chararray,
	order_date:chararray,
	order_no:chararray,
	price:int,
	prod_no:chararray);


-- * ユーザ単位でグルーピング
minfo_0 = COGROUP member BY mid, fav_list BY mid, purch_hist BY mid;
minfo = FOREACH minfo_0 GENERATE
	FLATTEN($1),
	$1.act_date AS mdate,
	$2,
	$3;


-- * ユーザごとに
--   * 対象外データ除外
--     * 論理削除された会員を除外
--     * 有効化以前のお気入りを除外
--     * 有効化以前の購入履歴を除外
--   * 抽出条件でフィルタリング

filter_0 = FOREACH minfo {

	-- * 対象外データ除外
	--   * 論理削除された会員を除外 (GENERATE句で評価)
	--   * 有効化以前のお気入りを除外
	--   * 有効化以前の購入履歴を除外
	mfav_0 = CROSS fav_list, mdate;
	mfav = FILTER mfav_0 BY fav_list::reg_date >= mdate::act_date;
	mpurch_0 = CROSS purch_hist, mdate;
	mpurch = FILTER mpurch_0 BY purch_hist::order_date >= mdate::act_date;

	-- 金額計算のためにデータ収集。
	amount_price = mpurch.price;

	-- * 出力項目を形成
	--   * 結果項目
	GENERATE $0 .. $4,
	(IsEmpty(amount_price) ? 0 : SUM(amount_price)) AS amount,

	--   * 抽出条件評価値
	(member::del_flag == '0' AND ( -- 論理削除された会員を除外

		-- * 抽出条件でフィルタリング
		--   * お気入り商品を登録している30～40代
		--   * 通常顧客で購入金額が5000円以上
		--   * 優良顧客で購入金額が10000円以上
		(age >= 30 AND age < 50)
		AND
		(NOT IsEmpty(mfav))
		AND
		(
			(rank == 'N' AND SUM(amount_price) >= 5000)
			OR
			(rank == 'S' AND SUM(amount_price) >= 10000)
		)

	) ? 1 : 0) AS cond
	;
}

result = FILTER filter_0 BY cond == 1;


-- * 結果項目を出力

DESCRIBE result;
EXPLAIN result;
DUMP result;
