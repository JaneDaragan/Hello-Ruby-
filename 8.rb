class Array
  def square
   self.map {|n| n**2}
  end

  def average
   return 0 if self.detect{|n| n.class != Integer}
   self.sum / self.size
  end

  def even_odd
    even =[]
    odd =[]
    self.map {|n| n.even? << even}
    self.map{|n| n.odd? << odd}
    result = even.size - odd.size
    p result
  end

  def reverse_strings
    self.map {|string| string.reverse}
  end
end
