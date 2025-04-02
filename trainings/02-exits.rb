fruits = ['banana', 'apple', 'pear']

fruits.each do |fruit|
  if fruit == 'apple'
        #break #goes on the next code
        #exit #doesn't continue to next code it sees
        #exit! #doesn't continue to next code it sees
        #abort("failed on apple") #doesn't continue to next code it sees
        redo #will stuck at this loop
  end
    puts fruit.upcase
end
puts "total fruits are #{fruits.count()}"