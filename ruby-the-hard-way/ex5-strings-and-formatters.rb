my_name = 'test'
my_age = 20
#my_height = 130
#my_eyes = 'blue'

#use format sequence
puts "lets talk about %s" % my_name
puts "i am %d years old" % my_age

#use interpolation
puts "in other form i am #{my_age} old and I am #{my_name}"

#another method
sprintf('Name: %s; value: %d', 'my_name', 0)

#multi-line strings
formatter = "%s %s %s"
#puts formatter % [formatter, formatter, formatter, formatter]
puts formatter % [
    "i had this thing",
    "that could've gone wrong",
    "very great", #next line would not be printed out cause we have inserted 3 string formatter in formatter variable
    "once again"
]

days = "Mon Tue Wed Thu Fri Sat Sun"
months = "Jan\nFev\nMar\nApr\nMay\nJun\nJul\nAug"
puts "here are days: ", days
puts "here are months: ", months

#inserting a paragraph
puts <<PAR
here it inserted
as example
PAR

my_var = "\t* cat"
puts my_var