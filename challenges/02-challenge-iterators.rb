colors = "RRGGBBYYKK"
#use split to work with array instead of string
#color_array = colors.split('')
##puts color_array.class
##puts color_array[6]
#puts color_array.shift()
#lines = 20
#1.upto(lines) do |i|
#    first_char = color_array.shift()
#    color_array << first_char
#    puts color_array.join
#end

#string bersion of script
lines = 20
lines.times do |i|
    first = colors[0]
    rest = colors[1..-1]
    colors = rest + first
    puts colors
end

