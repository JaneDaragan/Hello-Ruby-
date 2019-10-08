class Route

#@@routes_keys = []
@@routes = {}

def self.all
  @@routes
  #all_routes = @@routes_keys.product(@@routes).to_h
end

 attr_reader :stations, :name
 attr_accessor :first, :last

 def initialize(first, last)
   @first = first
   @last = last
   @stations = [first, last]
   @name = "#{first.name} - #{last.name}"
   #@@route_keys << @stations
   #@@routes << self
   @@routes[self] = self.stations
 end

 def add_substation(substation)
   stations.insert(-2,substation)
 end

 def delete_substation(substation)
   stations.delete(substation) if substation != stations[0]||substation != stations[-1]
 end
end
