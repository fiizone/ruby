the_count = [1,2,3,4,5]
fruits = ['apples', 'oranges', 'pears', 'apricots']
change = [1, 'pennies', 2, 'dimes', 3, 'quarters']

#going through arrays:
for number in the_count
    puts "this is count: #{number}"
end

#same as abow but with a block instead:
the_count.each do |each|
    puts "here are all numbers: #{each}"
end

fruits.each do |fruit|
    puts "here are fruit types: #{fruit}"
end

for i in change
    puts "i have these changes: #{i}"
end

element = []

for i in (0..5)
    element.push(i)
end
for i in element
    puts "i have these in element: #{i}"
end