input_file = ARGV[0]

def print_all(f)
    puts f.read
end

#this function Resets the file pointer to the beginning of the file.
def rewind(f)
    f.seek(0, IO::SEEK_SET)
end

def print_a_line(line_count, f) 
    puts "#{line_count} #{f.readline()}" #reads one line from the file (up to a newline \n) and advances the pointer to the next line.
end

current_file = File.open(input_file)

puts "first lets print the whole file:"
puts

print_all(current_file)

puts"now lets rewind line by line"

rewind(current_file)

puts "let's print first three lines:"

current_line = 1
print_a_line(current_line, current_file)

current_line = current_line + 1
print_a_line(current_line, current_file)

current_line = current_line + 1
print_a_line(current_line, current_file)