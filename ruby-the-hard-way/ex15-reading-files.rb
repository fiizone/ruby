filename = ARGV.first
prompt = '> '
txt = File.open(filename)

puts "here is your file name: #{filename}"
puts txt.read()

puts "I'll also ask you to type it again"
print prompt
file_again = STDIN.gets.chomp()

txt_again = File.open(file_again)
puts txt_again.read()