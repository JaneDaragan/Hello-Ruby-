class Station
 attr_reader :name, :trains
 def initialize(name)
   @name = name
   @trains = []
 end

 def accept_train(train)
   @trains << train
 end

 def send_train(train)
   @trains.delete(train)
 end

 def trains_type(type)
   @trains.select {|train| train.type == type}
 end
end

class Route
 attr_reader :stations, :first, :last
 def initialize(first, last)
  @first = first
  @last = last
  @stations = [first, last]
 end

 def add_substation(substation)
  @stations.insert(-2,substation)
 end

 def delete_substation(substation)
  @stations.delete(substation) if substation != @stations[0]||substation != @stations[-1]
 end

 def route_stations
  @stations
 end
end

class Train
 attr_reader :type, :speed, :wagon_quantity
 def initialize(number,type)
  @number = number
  @type = type
  @wagon_quantity = 0
  @speed = 0
 end

 def go(speed)
  @speed += speed
 end

 def stop
  @speed = 0
 end

 def add_wagon
  return "Error" if @speed != 0
  @wagon_quantity +=1
 end

 def delete_wagon
  return "Error" if @speed != 0
  @wagon_quantity -=1
 end

 def take_route(route)
  @route = route
  @current_station = @route.route_stations.first
  @current_station.accept_train(self)
 end

 def current_station
  @current_station
 end

 def next_station
  @index = @route.route_stations.find_index(@current_station)
  @next_station = @route.route_stations[@index +1]
 end

 def previous_station
   @index = @route.route_stations.find_index(@current_station)
   @previous_station = @route.route_stations[@index-1]
 end

 def move_forward
  return "No way forward.It is the last station" if @current_station == @route.route_stations[-1]
  @current_station.send_train(self)
  @next_station.accept_train(self)
  @current_station = @next_station
 end

 def move_back
  return "No way back.It is the first station" if @current_station == @route.route_stations[0]
  @current_station.send_train(self)
  @previous_station.accept_train(self)
  @current_station = @previous_station
 end
end
