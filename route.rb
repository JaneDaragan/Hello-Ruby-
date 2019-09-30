class Route
 attr_reader :stations, :name
 attr_accessor :first, :last
 def initialize(first, last)
   @first = first
   @last = last
   @stations = [first, last]
   @name = "#{first.name}, #{last.name}"
 end

 def add_substation(substation)
   stations.insert(-2,substation)
 end

 def delete_substation(substation)
   stations.delete(substation) if substation != stations[0]||substation != stations[-1]
 end
end
