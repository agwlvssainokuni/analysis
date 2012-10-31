#!/bin/bash
#
# Copyright 2012 agwlvssainokuni
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

for f in $(find www.post.japanpost.jp -name '*.csv')
do
	dname=$(dirname ${f})
	bname=$(basename ${f} .csv)
	pref=$(echo ${bname} | awk '{print substr($1, 1, 2);}')
	iconv -f Shift_JIS -t UTF-8 ${f} | \
		sed -e 's/"//g;' -e 's/,/\t/g;' | \
		awk -v pref=${pref} \
			'BEGIN {line=0;} {printf("%s%04d\t%s\n", pref, line++, $0);}' \
		> ${dname}/${bname}_utf8.tsv
done
