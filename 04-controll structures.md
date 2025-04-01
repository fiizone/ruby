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
