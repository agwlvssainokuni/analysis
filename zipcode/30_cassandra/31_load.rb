#!/usr/bin/ruby
# coding: utf-8
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

require 'cassandra'

col_fam = ARGV.shift

client = Cassandra.new('ZIPS', '127.0.0.1:9160')
client.disable_node_auto_discovery!
ARGF.each {|line|

	line.chop!

	key = nil
	cols = {}
	index = 0
	line.split("\t").each {|v|
		if index == 0
			key = v.force_encoding("ASCII-8BIT")
		else
			cols[sprintf('%02d', index)] = v.force_encoding("ASCII-8BIT")
		end
		index += 1
	}

	begin
		client.insert(col_fam.to_sym, key, cols)
	rescue
		client.disconnect!
		client.insert(col_fam.to_sym, key, cols)
	end
}
