
def score_throws(radiuses)
  return 0 if radiuses.empty?
  array=[]
  radiuses.each do |r|
    array << 0 if r > 10
    array << 10 if r < 5
    array << 5 if r >= 5 && r <= 10
  end

  score = array.sum
  score += 100 if radiuses.all? {|r| r <= 5}

  puts "Score: #{score}"
end
