#!/usr/bin/env ruby

#Directory as argument
d=ARGV[0]
require "./order.rb"
if ! d
 d="."
end

files=`find #{d} -type f | xargs stat -c "%s %n" 2>/dev/null`
s=files.split("\n")

sk=[]
sv=[]

i=0
s_size=s.size
while i < s_size
  sk<<s[i].split(" ")[1]
  sv<<s[i].split(" ")[0]
  i+=1
end


#Creating hash
j=0
h={}
#puts "sv size is #{sv.size}"
#puts "s_size is #{s_size}"
while j < sv.size
  #puts j
  h[sk[j]]=sv[j]
  j+=1
end


z=0

#Getting uniq values of each hash value
u=h.values.uniq
while z < h.size
# puts z
 same_files=h.select { |k,v| v==u[z] }
 if same_files.size >= 2
   fs=0
   while fs < same_files.size
    count=fs+1
    count=order count 
    #puts  "same_file size with #{u[z]} bytes , #{order fs+1} files #{same_files.keys[fs]}"
    puts  "same_file size with #{u[z]} bytes , #{count} file is #{same_files.keys[fs]}"
    fs+=1
   end
 end
 z+=1
end
