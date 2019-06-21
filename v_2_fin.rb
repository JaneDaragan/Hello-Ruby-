
puts "I will help you to find out what kind of triangle you have. Just give me three sides of your triangle.So type me the first side"
first = gets.chomp.to_f
a = first
puts "Type the second side"
second = gets.chomp.to_f
b = second
puts "Type the third side please"
third = gets.chomp.to_f
c = third

array = [a,b,c]
hypotenuse = array.sort![2]
kat1 = array[0]
kat2 = array[1]

right = hypotenuse**2 == kat1**2 + kat2**2

if right
  puts "This triangle is righ angled"
elsif right && kat1 == k2
  puts "This is right angled triangle and equilaterial"
elsif kat1 == kat2 == hypotenuse
  puts "This is triangle with equal sides but not right angled"
else
  puts "This is regular triangle"
end
