# define and call methods & variable scope & methods arguemtns & return value

## methods definition

- we have used methods before like this
  
  ```ruby
  "hello".reverse.capitalize
  1.upto(5) {...}
  [1,2,5,7].sort {...}
  ```

- methods are instructions to performa specific task, packaged as a unit which we can call in our code, in other languages we may call them functions but in ruby as everything is an object we call them methods

- must be defined before they can be called

- can be redefined without error

## methods naming

- generally lowercase with underscores

- first character must be lowercase or underscore

- name can only contain letters, digits, underscores

- last character can also be `? ! =`

## syntax for methods

```ruby
def some_name
    #...
end 

def blanket_patterns(colors, lines)
    lines.times do |i|
        first = colors[0]
        rest = colors[1..-1]
        colots = rest + first
        puts colors
    end
end

blanket_patterns('++*~~*++*', 20)
```

## variable scope

- local variables inside methods only have scope inside methods

- local variables outside methods do not have scope inside methods

- global, class and instance variables have scope both outside and inside methods

## methods arguments

- allow a method to receive values at runtime

- comma-separated list of variables after the method name

- "`args`"

- order and number of arguments passed in must match definition

- ```ruby
  def volume(x, y, z)
      x * y * z
  end
  volume(2,3,4)
  ```

### argument parentheses

- argument paranteses are optional

- methods with arguments use them

- methods without arguments do not use them

- both when defining and calling methods

- ```ruby
  volume 2,3,4 #without parentheses
  ```

## argument default values

- any ruby object cab be used as default value:

- it's a good approach to have required arguemnts listed first and optional arguments listed last

```ruby
def welcome(greeting, name, punct='!')
    greeting + ' ' + name + punct
end

puts welcome('Hello', 'friend')
#Hello friend!
```

```ruby
def out_of_stock(items=[])
    items.find_all {|item| item.qty == 0}
end
```

```ruby
def fight!(weapon=nil)
    if weapon
        fight_using_weapon(weapon)
    else
        fight_using_hands
    end
end
```

if we want to have flexibility, all the optional arguemnts go in the options like this:

```ruby
def welcome(greeting, options={})
    name = options[:name] || 'friend'
    punct = options[:punct] || '!'
    greeting + ' ' + name + punct
end

puts welcome('hello', {:punct => '!!!'})
```

## return value

- methods return the last operation's value by default

- `return:` return a value and exit the method

- useful in conditional statements and loops

- not necessary in last line of method

- using `puts` returns `nil`

- it is much better not to use `puts` or `print` in most methods even if they are not last line of a method

- ```ruby
  def subtract(n1, n2)
      result = n1 - n2
      result = 0 if result < 0
  end
  
  subtract(8, 3)
  #nil
  
  def subtract(n1, n2)
      result = n1 - n2
      result = 0 if result < 0
      result
  end
  
  subtract(8, 3)
  #5
  ```

## return multiple values

- methods can only ret rn one value

- use an array or hash to return multiple values

- ```ruby
  def add_and_subtract(n1, n2)
      add = n1 + n2
      sub = n1 - n2
      [add, sub]
  end
  
  result = add_and_subtract(8, 3)
  a = result[0]
  s = result[1]
  ```
  
  ```ruby
  def add_and_subtract(n1, n2)
      add = n1 + n2
      sub = n1 - n2
      {:add => add, :sub => sub}
  end
  
  result = add_and_subtract(8, 3)
  a = result[:add]
  s = result[:sub]
  ```

- we better go with arrays cause we have sth named multiple assignment using comma seperated variables like below:
  
  ```ruby
  def add_and_subtract(n1, n2)
      add = n1 + n2
      sub = n1 - n2
      [add, sub]
  end
  
  a, s = add_and_subtract(8, 3)
  ```
