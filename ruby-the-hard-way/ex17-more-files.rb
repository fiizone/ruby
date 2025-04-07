fromFile, toFile = ARGV
#script = $0

puts "copying from #{fromFile} to #{toFile}"

input = File.open(fromFile)
indata = input.read()

puts "the input file is #{indata.length} bytes long"

puts "does the output file exist? #{File.exist? toFile}"
puts "okay then, hit RETURN to continue, CTRL-C to abortion"
STDIN.gets

output = File.open(toFile, 'w')
output.write(indata)

puts "alright, all done"

output.close
input.close