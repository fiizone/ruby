# Essentials - array-symbols-booleans

## array

an ordered, integer-indexed collection of objects, we can put any objects in arrays

```ruby
empty_array = []
my_array = ['a', 'b', 100]
my_array[1] #index b
```

set value to an array:

```ruby
my_array[1] = 'q' #sets second index value to 'q'
my_array << 'e'
```

get values from array

```ruby
array[2] #3rd item
array[-1] #last item
array[2,4] #item of index 2 and 4 values after that
array[-2,3] #gives us last three objects
array[2..5] #gibes us items from index 2 till 5
array[-4..-1] #gibes us items from -4 till -1
```

### array methods:

```ruby
array = [2, 4, ["a", "b"], nil, 4, "c"]
array.length #6
array.size #6
array.reverse #["c", 4, nil, ["a", "b"], 4, 2]
array.reverse! #permanently reversing the array
array.shuffle #evident
array.shuffle! #evident
array.uniq #remove duplicate values
array.uniq!
array.compact #removes nil values
array.compact!
array.flatten #take the inner array and break it apart
array.flatten!
array.include?(2) #return true or false
array.delte_at(1) #object at index 1; delting and shifting things over and we don't have nil instead of it
array.delte('c') 
[1,2,3,4].join(',')
"1,2,3,4".split()
```

### other array methods:

```ruby
push
pop
shift
unshift
```

### addition and subtraction

```ruby
[1,2,3] + [3,4,5] #[1,2,3,3,4,5]

irb(main):097> [1,2,3,5] - [2,3,6,7,8,9]
=> [1, 5]
```

## hash (like dictionary in python)

**an unordered, object indexed collection of objects (or key-value pairs)**

> - like a labeled, hanging file folder
> 
> - order not important
> 
> - find items by key, not position
> 
> - as we want to find by keys, so hash keys must be unique

```ruby
car = {
    'brand' => 'ford',
    'model' => 'mustang',
    'color' => 'blue',
    'interior_color' => 'tan'
}
```

- calling for values of hash:
  
  - ```ruby
    puts car['model'] #same as array but instead of index we specify key
    ```

- modifying value of a key:
  
  - ```ruby
    car['color'] = 'green'
    car['doors'] = 4 #even add new key-value
    ```

- return all keys or values in hash
  
  - ```ruby
    car.keys
    car.values
    car.length
    car.size
    ```

- turn back our `hash` to `array`
  
  - ```ruby
    car.to_a
    ```

## symbols

> - like strings but cannot be edited
> 
> - begins with a colon
> 
> - not delimited by quotes
> 
> - naming follows rules that are almost variables: lowercase, underscore, no space
> 
> - `:first_name` for example
> 
> - it is more like a variable that acts like a label

```ruby
person = {
    :first_name => 'benjamin',
    :last_name => 'franklin'
}

person[:last_name]
```

why does ruby have symbols?

1. it is not immutable

2. when having a string like `"test"` ruby assings an id to it like this `"test".object_id` that changes every time, whereas in symbols the object_id sticks aroung, so manages them differently in memory

## booleans

an object that can be either `true` or `false` use for camparissions

| operation             | syntax |
| --------------------- | ------ |
| equal                 | ==     |
| less than             | <      |
| greater thatn         | >      |
| less than or equal to | <=     |
| greater than or equal | >=     |
| not                   | !      |
| not equal             | !=     |
| and                   | &&     |
| or                    | |\|    |


