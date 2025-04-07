def puts_two(*args)
  arg1, arg2, arg3 = args
  puts "arg1: #{arg1}, arg2: #{arg2}, arg3: #{arg3}"
end

puts_two("Zed","Shaw",["1"=> "first", "2"=> "second"])