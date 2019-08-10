def parse_array(array)
  return "Error" unless array.any?{|arr| arr.is_a?(Integer) || arr.is_a?(String)}
  yield (array) if block_given?
end

array = ['apple', 'notebook', 2, 'water', 10, 11, 12]

parse_array(array) do |array|
  p array.select {|num| num.class == Integer }
end

parse_array(array) do |array|
  p array.select {|num| num.kind_of?(String) }
end

parse_array(array) do |array|
  new_hash = {}
  array.each.with_index do |n, index|
  new_hash[index + 1] = n
  end
  p new_hash
end

#важно тестировать все вещи в irb - и если что то не понятно выявлять ошибки, который раз уже Дима это повторяет
