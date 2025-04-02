# controll structures

- add dynamism to code

- determine circumstances when code executes

- conditionals

- loops

- iterators: more like loops but instead of executing a number of times it uses a `set of objects` and executes the code once each time for those objects, those objects are typically stored in array or hash and iterator will loop as it moves through that array or hash using each object in turn

## conditionals: if, else, elsif

#### if statement:

```ruby
if boolean
   #...
end

if fruit == 'apple'
   puts fruit.upcase
end
```

#### else statement:

```ruby
if boolean
   #...
else
   #...
end
```

#### elsif statement:

```ruby
if boolean
   #...
elsif boolean
   #...
else
   #...
end
```

#### unless statement:

- same as `if !boolean`

```ruby
unless boolean
   #...
end

unless array.empty?
   #...
end

unless search_result.nil?
   #...
end
```

#### case statement:

we often use case when we have bunch of `ifs`

```ruby
case
when boolean
   #...
when boolean
   #...
else
   #...
end

case
when count == 0
   puts "nobody"
when count == 1
   puts "one person"
when (2..5).include?(count)
   puts "several people"
else
   puts "many people"
end
```

- case with comparisons:
  
  - ```ruby
    case count #here comes the variable
    when 0
       puts "nobody"
    when 1
       puts "one person"
    when 2..5
       puts "several people"
    
    else
       puts "many people"
    end
    ```

# shorthand operators:

## ternary operator

the structure is pretty much like this:

```ruby
boolean ? result_true : result_false
```

```ruby
puts count == 1 ? "person" : "people"
#same as below:
if count == 1
   puts "person"
else
   puts "people"
end
```

## or operator:

if `y` doesn't have a value, if it is `nil` or if it evaluates as `false` then use `z` instead

```ruby
x = y || z
#same as below
if y
   x = y
else
   x = z
end
```

## or-equals operator:

if `x` has a value then use it, don't do anytying else, then if it doesn't have a value, set it to a value of `y`

```ruby
x ||= y
#same as below
unless x
   x = y
end
```

## statement modifiers:

```ruby
puts "hello" if greeting_enabled
score += 10 unless score >= MAX_SCORE
```

### examples on short-hand operators:

```ruby
count = 2
puts count == 1 ? "#{count} person" : "#{count} people"

DEFAULT_LIMIT = 100
limit = nil
max = limit || DEFAULT_LIMIT #here max becomes 100
#this can be done as below
limit = DEFAULT_LIMIT unless limit
```

## loops

- infinite loop:
  
  - ```ruby
    loop do
       #...
    end
    ```

- control methods:
  
  - `break:` terminate the whole loop
  
  - `next:` jump to next loop
  
  - `redo:` redo this loop
  
  - `retry:` start the whole loop over

- loops: example
  
  - a way of loops that is very rare to see:
    
    ```ruby
    i = 5
    loop do
        break if i <= 0
        puts "countdown: #{i}"
        i -= 1
    end
    puts "blast off"
    ```
  
  - more common to see `while, until`: while => as long as the boolean expression is `true`, the loop goes on till it sees `false`; until => it runs as long as the boolean expression evaluates to `false` so run until sth becomes `true`
    
    ```ruby
    while boolean
        #...
    end
    ##
    i = 5
    while i > 0
        puts "countdown: #{i}"
        i -= 1
    end
    puts "blast off"
    ##
    until boolean
        #...
    end
    
    i = 5
    until i < 0
        puts "countdown: #{i}"
        i -= 1
    end
    puts "blast off"
    ```

## iterators:

- to say or do again

- to apply a procedure repeatedly

- to perform code on each item in a set

- example:
  
  - ```ruby
    i = 5
    i.times do
        puts "countdown: #{i}"
        i -= 1
    end
    puts "blast off"
    ```

### iterators types:

- times
  
  - `5.times { puts "hello"}`

- upto
  
  - `1.upto(5) {puts "hello"}`

- downto
  
  - `5.downto(1) {puts "hello"}`

- each
  
  - `(1..5).each {puts "hello"}`

### iterators: block variables

```ruby
5.downto(1) do |i|
    puts "countdown: #{i}"
end
puts "blast off"
#we can use below but we are missing block variables there
i = 5
i.times do
    puts "countdown #{i}"
    i -= 1
end
puts "blast off"
```

### iterators: by class

- integer: `times, upto, downto, step`

- range: `each, step`

- string: `each_line, each_char, each_byte`

- array: `each, each_index, each_with_index`

- hash: `each, each_key, each_value, each_pair`

### iterators: for...in

```ruby
fruits = ['banana', 'apple', 'pear']
fruits.each do |fruit|
    puts fruit.capitalize
end

for fruit_fafa in fruits
    puts fruit_fafa.capitalize
end
```

## challenge

- colors = "RRGGBBYYKK"

- output 20 rows

- on each row, shift the characters to the left by removing the first character and putting it at the end

- "RGGBBYYKKR"

- solutions:

- ```ruby
  #string version of script
  colors = "RRGGBBYYKK"
  lines = 20
  lines.times do |i|
      first = colors[0]
      rest = colors[1..-1]
      colors = rest + first
      puts colors
  end
  
  #array version of the script
  colors = "RRGGBBYYKK"
  use split to work with array instead of string
  color_array = colors.split('')
  #puts color_array.class
  #puts color_array[6]
  #puts color_array.shift()
  lines = 20
  1.upto(lines) do |i|
      first_char = color_array.shift()
      color_array << first_char
      puts color_array.join
  end
  ```
