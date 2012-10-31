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

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=HBASE_ROW_KEY,c1:01,c1:02,c1:03,c1:04,c1:05,c1:06,c1:07,c1:08,c1:09,c1:10,c1:11,c1:12,c1:13,c1:14,c1:15,c1:16 zips zipcode/dl/oogaki/lzh

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=HBASE_ROW_KEY,c2:01,c2:02,c2:03,c2:04,c2:05,c2:06,c2:07,c2:08,c2:09,c2:10,c2:11,c2:12,c2:13,c2:14,c2:15,c2:16 zips zipcode/dl/kogaki/lzh

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=HBASE_ROW_KEY,rm:01,rm:02,rm:03,rm:04,rm:05,rm:06,rm:07,rm:08,rm:09,rm:10,rm:11,rm:12 zips zipcode/dl/roman
