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


