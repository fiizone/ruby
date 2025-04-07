i  = 0
numbers = []

while i < 6
    numbers.push(i)

    i += 1
    puts "numbers now is: #{numbers}"
    puts "the counter is: #{i}"
end

puts "the numbers are as below: "
for num in numbers
    puts num
end