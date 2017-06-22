def one_time_value(a)
   uniq_values=a.uniq
   siz=uniq_values.size-1
   for i in (0..siz)
     result=a.select { |s| s==uniq_values[i] }
     if result.size==1
        p result[0]
     end
   end
end

#https://stackoverflow.com/questions/8365721/remove-duplicate-elements-from-array-in-ruby/13112875#13112875
def one_time_value2(a)
   counts = Hash.new(0)
   a.each { |v| counts[v] += 1 }
   puts counts.select { |v,count| count == 1 }.keys
end
a=[1,1,1,1,2,2,2,9]
#one_time_value(a)

t=[1,1]*2 + [9] + [2,2,2] + [3,3,3] + ([1000]*10000000) + [10000000000]

#one_time_value2(a)
#one_time_value2(t)
#Take long time "one_time_value"
#one_time_value(t)


def one_time_value3(a)
   uniq_values=a.uniq
   siz=uniq_values.size-1
   for i in (0..siz)
     result=a.select { |s| s==uniq_values[i] }
     #p result.select { |v| v.size == 1; break; }
     p result[0] if result.size==1
   end
   #p result.select { |v| v.size == 1 }
end

one_time_value3(t)

one_time_value2(t)
