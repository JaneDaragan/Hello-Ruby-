# attempt to solve after lesson

puts "Please print what day is today"
day = gets.chomp.to_i

puts "Please print month?"
month = gets.chomp.to_i

puts "Please print year?"
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year%4==0 && year%400==0 && year%100!=0
   days[1]=29
end

if month == 1
    puts "Index is #{day}"
end

index = days [0...(month-1)].sum+day
 puts "Index is #{index}"

# в коде все равно есть ошибка но я не могу понять где она, через тест 31 декабря 2016 года, високосный год, индекс выдает 365, а должно быть 366. Может быть что-то не так с control flow ?
