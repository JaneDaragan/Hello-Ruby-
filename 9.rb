def items
(
  {:name=>"Snickers", :code=>"A01", :quantity=>10, :price=>250},
  {:name=>"Pepsi", :code=>"A02", :quantity=>5, :price=>350},
  {:name=>"Orange Juice", :code=>"A03", :quantity=>10, :price=>400},
  {:name=>"Bon Aqua", :code=>"A04", :quantity=>7, :price=>120},
  {:name=>"Bounty", :code=>"A05", :quantity=>10, :price=>270}
)
end

def sale (code, price)
 item = items.detect {|item|item[code] = code}
 return "#{item}:нет такого товара" unless item
 return "#{item[:name] закончился}" if items[:code]==code && items[:quantity] == 0

 if n[:price] == price
 total = n[:quantity]
 n[:quantity] = total-1
 p n[:name]

 elsif n[:price] < price
  puts "#{n[:name]} ваша сдача = #{price - n[:price]}"

 elsif n[:price] > price
  puts "Внесите еще #{price - n[:price]}"
 end
end
