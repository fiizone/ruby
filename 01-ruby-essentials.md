# 

# Essentials - variables - numbers - strings

## first things first:

- docs site is here: [Ruby-Doc.org: Documenting the Ruby Language](https://ruby-doc.org)

- to have interacive shell we can issue these commands:
  
  ```bash
  irb
  irb --simple-prompt
  ```

- to have docs we have other alternative too in command line and pass class name to it
  
  ```bash
  ri String
  ri String#upcase
  ```

- variable scope indicators
  
  | scope    | indicator  |
  | -------- | ---------- |
  | Global   | \$variable |
  | Class    | @@variable |
  | Instance | @variable  |
  | Local    | variable   |
  | Block    | variable   |
  
  ## Numbers:
  
  1. `integers`
     
     ```ruby
     X = 4
     X += 2 #same as: X = X + 2
     X -= 1
     X *= 2
     X /= 5
     1234.class #turns back class it is
     ```
     
     integer methods (call methods on objects in ruby):
     
     ```ruby
     100.class #integer
     100.next #101
     
     temp = -50
     temp.abs #50
     ```
  
  2. `floating-point numbers`
     
     ```ruby
     price = 12.34
     tax = 0.66
     price + tax #gives float
     
     13.0.class #float
     13.class #integer
     ```
     
     if we add precision, ruby keeps that precision, like 10.0 divided to 3 gives us float wherease 10/3 gives us integer
     
     change between differnet types:
     
     ```ruby
     10.to_f / 3.0.to_i
     ```

### number methods:

- `abs`

- `round`

- `floor`

- `ceil`
  
  ```ruby
  12345.123.round
  12345.123.to_i
  ```

## Strings

- a string of characters

- letters, numbers, symbols

- spaces, tabs, line returns

- `concatenation`
  
  - ```ruby
    greeting = "hello"
    target = 'world'
    greeting + ' ' + target
    ```

- `multiplication`
  
  - ```ruby
    "yale " * 3
    "1" * 3 #111
    1.to_s * "3".to_i #111
    ```

### methods on strings:

- `reverse`

- `capitalize`

- `upcase`

- `reverse.capitalize`: we could use two methods one after another cause we are facing with object

- `downcase`

- `length`

### strings escaping and interpolation:

```ruby
"let's escape" => valid
'let"s escape' => valid
"let"s escape" => invalid we want escape character "\"
```

**to use \t and \n as their real meaning we have to use double quotes "" instead of single quotes ' '**

#### interpolation:

<u>**Interpolcation only works with double quotes**</u>

insert something of a different nature into something else like example below:

```ruby
msg = 'helo'
puts "i just called you to say: #{msg}."

#not only variable but also ruby operations like this:
puts "1 + 1 = #{1+1}"

puts "i just called #{msg.upcase}"
```
