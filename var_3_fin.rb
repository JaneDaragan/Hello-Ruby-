puts "input a"
a = gets.chomp.to_f

puts "input b"
b = gets.chomp.to_f

puts "input c"
c = gets.chomp.to_f

d = b**2-4*a*c

if d < 0
 puts "Корней нет"
elsif d == 0
 x = -b /2*a
 puts "Один корень:x = #{x}"
else
  x1 = -b + Math.sqrt{d} / 2*a
  x1 = -b - Math.sqrt{d} / 2*a
  puts "Корни уравнения: x1 = #{x1}, x2 = #{x2}"
end


     
