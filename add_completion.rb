#!/usr/bin/env ruby
# To insert require irb/completion
# First install readline.rb
# To check rb-readline gem installed?
check_rl=system('gem list | grep rb-readline 1>/dev/null')
if ! check_rl
 system('gem install rb-readline -V')
end

# To remove "\n" character
irb_file=`which irb`.gsub("\n","")

# Each lines into memory(array)
irb_file_arr=File.open(irb_file,"r").readlines

check_comp=irb_file_arr.include?("require \"irb/completion\"\n")
 if check_comp != true
  #To find index of require irb lines (index)
  req_irb_index=irb_file_arr.index("require \"irb\"\n")

  #To insert "irb/completion" after req_irb_index content
  new_irb_array=irb_file_arr.insert(req_irb_index+1,"require \"irb/completion\"\n")

  # Open write mode on irb_file
  new_irb_w=File.open(irb_file,"w")

  #Write new_irb_array into irb file
  new_irb_w.write new_irb_array.join

  #Clear memory and close opened file
  new_irb_w.close
  new_irb_array.clear
  puts "Successful of adding completion function into irb file"
else
  puts "Completion function already added into irb file"
end
