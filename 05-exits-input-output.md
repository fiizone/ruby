# exits, input&output

## exits:

these are ways to exit the code

```ruby
fruits = ['banana', 'apple', 'pear']

fruits.each do |fruit|
  if fruit == 'apple'
        #break #goes on the next code
        #exit #doesn't continue to next code it sees
        #exit! #doesn't continue to next code it sees
        #abort("failed on apple") #doesn't continue to next code it sees
        redo #will stuck at this loop
  end
    puts fruit.upcase
end
puts "total fruits are #{fruits.count()}"
```

## output:

- puts: adds a line return at the end

- print: just output what we asked to

## input:

for input we see sth like this

```ruby
print "what is your nmae?"
response = gets.chop()
#response = gets.chomp() 

#puts "hello, #{response}!"
print "hello, #{response}!"
```

**there is difference between these `chop` and `chomp` chop will kncok off very last character of the string while chomp will only drop line feed(`\n`)**

## challenge:

- ask player for their name

- say hello and explain rules

- pick a random number

- get player's guess

- tell player if guess is correct

- loop to allow three guesses






