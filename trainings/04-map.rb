fruits = ['apple', 'banana', 'pear']
cap_fruits = fruits.map do |fruit|
  fruit == 'pear' ? fruit.capitalize : fruit
end
puts cap_fruits

#y = fruits.map do |fruit|
#    if fruit == 'banana'
#            fruit.capitalize
#    else
#      fruit
#    end
#end
#puts y