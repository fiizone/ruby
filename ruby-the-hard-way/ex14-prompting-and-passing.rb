user = ARGV.first
prompt = '> '

puts "hi #{user}, i'm the #{$0} script"
puts "i'd like to ask you few Qs."
puts "do u know #{user}?"
print prompt
likes = STDIN.gets.chomp()

puts "where do u live #{user}?"
print prompt
lives = STDIN.gets.chomp()

puts "What kind of computer do you have?"
print prompt
computer = STDIN.gets.chomp()

puts <<PAR
      alright, so u said #{likes} about user.
      u live in #{lives}. not sure where that is
      and u have a #{computer}, awesome
PAR