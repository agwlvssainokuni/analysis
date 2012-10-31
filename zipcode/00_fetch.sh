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

url_oogaki=http://www.post.japanpost.jp/zipcode/dl/oogaki.html
url_kogaki=http://www.post.japanpost.jp/zipcode/dl/kogaki.html
url_roman=http://www.post.japanpost.jp/zipcode/dl/roman.html

for url in ${url_oogaki} ${url_kogaki} ${url_roman}
do
	curl -s ${url} | \
		ruby -rnokogiri -e "Nokogiri::HTML(ARGF).xpath('//a/@href').each {|u| puts u.value if u.value =~ /\/\d{2}\w+\.lzh$/ }" | \
		wget --base=${url} --input-file=- --force-directories
done
