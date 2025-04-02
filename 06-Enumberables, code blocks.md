# Enumberables, code blocks

## enumerables:

- countable items

- arrays

- ranges

- hashes

- strings (sort of) for example if it is english, we know every character takes 1 byte

### enumerables: methods:

- count

- each

## code blocks:

- many ruby methods will accept optional code block

- the code block usually modifies default behavior

a block of code for example between `do` and `end` we see in iterators

| curly-brace format                  | do-end format                             |
| ----------------------------------- | ----------------------------------------- |
| single-line blocks                  | multiline blocks                          |
| blocks that return data, no changes | blocks that perform actions, make changes |

### code blocks variables

```ruby
#multi-line style
5.downto(1) do |i|
    puts "countdown: #{i}"
end

#single-line style
5.downto(1) {|i| puts "countdown: #{i}"}
```

```ruby
scores = {low: 2, high: 8, avg: 6}

scores.each do |k,v|
    puts "#{k.capitalize}: #{v}"
end
```

### common usage

- `find`

- `map`

- `inject`

- `sort`

- `merge`

#### Find methods

- **find / detect**
  
  - ```ruby
    (1..10).find {|n| n == 5 }
    (1..10).find {|n| n % 3 == 0}
    
    fruits = ['apple', 'banana', 'pear']
    fruits.find {|fruit| fruit.length > 5 }
    
    pantry = {'apple' => 0, 'banana' => 1, 'pear' => 3}
    pantry.find {|k,v| v == 0}
    ```

- **find_all / select**

- **any?, none?**
  
  - ```ruby
    (1..10).any? {|n| n <= 5 }
    ```

- **all?, one?**

- **delete_if**
  
  - ```ruby
    numbers = [*1..10]
    numbers.delete_if {|x| x < 5}
    ```

#### map methods

- `map`/`collect` which can be used interchangeably

- iterate through an enumerable

- `map!` / `collect!` works the same but **replaces** array contents

- execute a code block on each item

- add the result of the block to a new **array**
  
  - ```ruby
    scores = {low: 2, high: 8, avg: 6}
    adjusted_scores = scores.map do |k,v| "#{k.capitalize}: #{v*100}"
    end
    
    #results like this:
    #["Low: 200", "High: 800", "Avg: 600"]
    ```

- **number of items in = number of items out**

```ruby
x = [1,2,3,4,5]
y = x.map {|n| n + 1 }
#x = [1,2,3,4,5]
#y = [2,3,4,5,6]
```

- another example to keep in mind:
  
  - ```ruby
    fruits = ['apple', 'banana', 'pear']
    y = fruits.map do |fruit|
        if fruit == 'pear'
            fruit.capitalize
        end
    end
    
    #results like this
    #[nil, nil, 'Pear']
    
    #while we have to use like this:
    fruits = ['apple', 'banana', 'pear']
    y = fruits.map do |fruit|
        if fruit == 'pear'
            fruit.capitalize
        else
            fruit
        end
    end
    #result this
    #['apple', 'banana', 'Pear']
    
    #in other syntax it is like this:
    fruits = ['apple', 'banana', 'pear']
    cap_fruits = fruits.map do |fruit|
      fruit == 'pear' ? fruit.capitalize : fruit
    end
    puts cap_fruits
    ```

#### inject methods:

- `inject` / `reduce`

- accumulates

- block variable to use for accumulation

- ruby convention:`memo`

examples:

```ruby
[3,5,7].inject {|memo, n| memo * n }
#(3*5)*7
```

```ruby
[2,4,6].inject {|memo, n| memo ** n }
#(2 ** 4)**6
```

**return values matter in inject**

```ruby
(1..5).inject do |memo, n|
    memoj + n
    x = 0
end
#Result is 0

(1..5).inject do |memo, n|
    if n % 2 == 0
        memo + n 
    end
end
#undefined method '+' for nil
```

- inject is not only for match, for example, here to get the length of our string
  
  - ```ruby
    fruits = ['apple', 'banana', 'pear']
    size = fruits.inject(0) do |memo, fruit|
        memo + fruit.length
    end
    ```
  
  - or in this example to find out which one has the longest name:
    
    ```ruby
    fruits = ['apple', 'banana', 'pear']
    longest = fruits.inject do |memo, fruit|
        if fruit.length > memo.length
            fruit
        else
            memo
        end
    end
    ```
  
  - at this example the initial value for inject is an empty string `''` and each time it takes first character of the variable and it adds it to the memo:
    
    ```ruby
    fruits = ['apple', 'banana', 'pear']
    mash = fruits.inject('') do |memo, fruit|
        memo << fruit[0]
    end
    ```


