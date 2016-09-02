#!/usr/bin/env ruby

def order(a)
 #a=a.to_i
 if a == 1
    a="first"   
 elsif a==2
    a="second"
 elsif a==3
    a="third"
 else
   a="#{a}th"
 end
end

order(1)
