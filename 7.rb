
def score_throws(radiuses)
  return 0 if radiuses.empty?
  array=[]
  radiuses.each do |r|
    radiuses = r.to_f
    array << 0 if radiuses > 10
    array << 10 if radiuses < 5
    array << 5 if radiuses >= 5 && radiuses <= 10
  end

  score = array.sum
  score += 100 if radiuses.all? {|r| r < 5}

  puts "Score: #{score}"
end
