# sort - merge

## sort

- sort methods use the comparison operator

- `<=>`

- value1 <=>
  
  | value | meaning   | movement    |
  | ----- | --------- | ----------- |
  | -1    | less than | moves left  |
  | 0     | equal     | stays       |
  | 1     | more than | moves right |
  
  1 <=> 2 results in -1
  
  ```ruby
  array = [5,8,6,1,3]
  x = array.sort { |v1,v2| v1 <=> v2 }
  # [1,2,3,5,6,8]
  x = array.sort { |v1,v2| v2 <=> v1 } #reverse order
  # [8,6,5,3,2,1]
  ```

- sort methods: `sort, sort_by`
  
  ```ruby
  fruits = ['banana','apple','pear']
  x = fruit.sort
  # ['apple', 'banana', 'pear']
  
  x = fruits.sort do |fruit1, fruit2|
      fruit1.length <=> fruit2.length
  end
  # ['pear', 'apple', 'banana']
  
  #not used much often
  x = fruit.sort_by {|fruit| fruit.length}
  # ['pear', 'apple', 'banana']
  
  #sort without <=> sign
  x = fruits.sort do |fruit1,fruit2|
      case fruit1
      when 'apple'; 1
      when 'banana'; -1
      when 'pear';0
      end
  end
  # ["banana", "pear", "apple"]
  ```

- `sort! / sort_by!`
  
  works the same but replaces array contents

- sorting hashes:
  
  when sorted hashes it returns an ordered set of array, it gets the hash and converts into array and then sorts the array
  
  ```ruby
  hash = {a: 4, c: 5, b: 3}
  hash.sort {|p1,p2| p1[0] <=> p2[0]}
  #[[:a, 4], [:b, 3], [:c, 5]]
  
  hash.sort {|p1,p2| p1[1] <=> p2[1]}
  #[[:b, 3], [:a, 4],  [:c, 5]]
  ```

## merge

- used for hashes only

- merges two hashes together

- block can provide rules to use when merging

- `merge!` works the same but replaces the hash content too

### merge without a block

```ruby
h1 = {:a => 2, :b => 4, :c => 6}
h2 = {:a => 3, :b => 4, :d => 8}
h1.merge(h2)
#{:a => 3, :b => 4, :c => 6, :d => 8}
h2.mgerge(h1)
#{:a => 2, :b => 4, :c => 6, :d => 8}
```

note that in case same key in two hashes had two values, the value of newer one meaning the one we are merging into stays in place, or we can provide a code block to tell ruby which one to keep

in this code snippet only executes when there is a key conflict and decide based on that:

```ruby
h1 = {:a => 2, :b => 4, :c => 6}
h2 = {:a => 3, :b => 4, :d => 8}

h1.merge(h2) {|key, old, new| new }
#{:a => 3, :b => 4, :c => 6, :d => 8}

h1.merge(h2) {|key, old, new| old }
#{:a => 2, :b => 4, :c => 6, :d => 8}
```

- in more fancy way we can even do something before deciding which one to keep:

we say if old value is less than new value then return old value and otherwise return the new one:

```ruby
h1 = {:a => 2, :b => 4, :c => 6}
h2 = {:a => 3, :b => 4, :d => 8}

h1.merge(h2) {|k, o, n| o < n ? o : n }
#{:a => 2, :b => 4, :c => 6, :d => 8}
```

- in this sceanario we say if there is a conflict, take the old value and new value and multiply them together, no matter if they have same value:

```ruby
h1 = {:a => 2, :b => 4, :c => 6}
h2 = {:a => 3, :b => 4, :d => 8}

h1.merge(h2) {|k, o, n| o * n }
#{:a => 6, :b => 16, :c => 6, :d => 8}
```
