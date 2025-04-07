#• close – Closes the file. Like File->Save.. in your editor.
#• read – Reads the contents of the file, you can assign the result to a variable.
#• readline – Reads just one line of a text file.
#• truncate – Empties the file, watch out if you care about the file.
#• write(stuff) – Writes stuff to the file.
filename = ARGV.first
#script = $0

puts "We're going to erase #{filename}."
puts "If you don't want that, hit CTRL-C (^C)."
puts "If you do want that, hit RETURN."

  print "? "
STDIN.gets

puts "Opening files ..."
target = File.open(filename, 'w')

puts "truncating file, say goodbye to its content :D"
target.truncate(target.size)

puts "now insert three lines, be polite."

print "line 1: "; line1 = STDIN.gets.chomp()
print "line 2: "; line2 = STDIN.gets.chomp()
print "line 3: "; line3 = STDIN.gets.chomp()

puts "writing to the file."

target.write(line1)
target.write("\n")
target.write(line2)
target.write("\n")
target.write(line3)
target.write("\n")

puts "we close the file here."

target.close()