=begin 2)  Дан массив строк.
Строки представляют из себя какое-то слово. Написать метод, который принимает этот массив,
и вычисляет сумму символов в самом коротком и самом длинном слове массива
и выводит на экран.
=end


def max_min(strings)
  max = []
    strings.each do |n|
      max << n.length.to_i
    end
    max.sort!
    puts "Min: #{max[0]}"
    puts "Max: #{max[-1]}"

end

n = ['bon', 'bejing', 'paris', 'oslo']
puts max_min(n)
