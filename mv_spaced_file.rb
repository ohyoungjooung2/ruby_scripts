#!/usr/bin/env ruby

plist=`find . -maxdepth 1 -type f | grep -i "puppet"`
plist_arr=plist.split("\n")

puts "list is #{plist_arr}"

des_dir="./puppet"

puts "Let's move into #{des_dir}"

plist_arr.each { |e| `mv -vf "#{e}" #{des_dir}` }
