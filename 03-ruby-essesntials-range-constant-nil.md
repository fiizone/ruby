# Essentials - ranges

## range

ranges are a range of sequencial objects, most of times they are numbers

| type            | value    |
| --------------- | -------- |
| inclusive range | `1..10`  |
| exclusive range | `1...10` |

difference between these two is that in exclusive range type, 10 is not included

most of the time we use inclusive ranges

```ruby
inclusive = 1..10
inclusive.class #Range
1..10.class #throws error use below instead
(1..10).class
exclisive = 1...10
inclusive.begin ~ inclusive.first
inclsuvie.end ~ exnclusive.last
```

- we can make an array out of inclusive range:

```ruby
array = [*inclusive]
```

- we can also have non numerical ranges:
  
  ```ruby
  alpha = 'a'..'m'
  ```

## constansts

- tyeh are not objects, they reference objects

- similar to variables

- used for storing values that are constant

- named using all uppercase

- we can actually change them but ruby warns us too.
  
  - ```ruby
    MAX = 100
    MAX = 50
    (irb):22: warning: already initialized constant MARK
    (irb):19: warning: previous definition of MARK was here
    ```

- the capiltalization convention only applies to first character so `Temp` is constant too.

## Nil

a simple object which means nothing

```ruby
nil.class #NillClass
nil == false #false
nil.nil? #true
```

- ways to see if values are set for a variable or not:
  
  - ```ruby
    product.nil? ~ product == nil ~ !product
    ```
