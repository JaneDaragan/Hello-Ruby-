=begin class Station
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
=end

class Route
 attr_reader :stations
 attr_accessor :first, :last
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

class PassengerTrain
 attr_reader :type,:number 
 attr_accessor :current_station
 def initialize
   @number = number
   @type = passenger
   @wagons = []
   @speed = 0
 end

 def add_wagon(wagon)
  return "Error" if @speed != 0
  return "Error" if wagon.type != passenger
   @wagons << wagon
 end

 def delete_wagon(wagon)
  return "Error" if @speed != 0
   @wagons.delete(wagon)
 end

 def take_route(route)
   @route = route
   @current_station = @route.route_stations.first
   @current_station.accept_train(self)
 end

 def move_forward
  return "No way forward.It is the last station" if @current_station == @route.route_stations[-1]
  return unless @current_station && @route.route_stations
   @current_station.send_train(self)
   next_station.accept_train(self)
   @current_station = next_station
 end

 def move_back
  return "No way back.It is the first station" if @current_station == @route.route_stations[0]
  return unless @current_stations && @route.route_stations
   @current_station.send_train(self)
   previous_station.accept_train(self)
   @current_station = previous_station
 end

 def current_station
   @current_station
 end
 
 def previous_station
   @route.route_stations[current_station_index -1]
 end

 def next_station
   @route.route_stations[current_station_index +1]
 end
  
 private # они приватные, потому что не реализовывают напрямую то логику которая требуется от класса, они вспомогательные по отношению к методам интерфейса класса

 def current_station_index
   @route.route_station.index(@current_station)
 end
end 

class PassengerWagon
 def initialize(seats_quantity,type)
   @seats_quantity = 52
   @type = passenger
 end
end

class CargoTrain
 attr_reader :type,
 attr_accessor :current_station
 def initialize
   @number = number
   @type = cargo
   @wagons = []
   @speed = 0
 end

 def add_wagon(wagon)
  return "Error" if @speed != 0
  return "Error" if wagon.type != cargo
  @wagons << wagon
 end

 def delete_wagon(wagon)
  return "Error" if @speed != 0
   @wagons.delete(wagon)
 end

 def take_route(route)
   @route = route
   @current_station = @route.route_stations.first
   @current_station.accept_train(self)
 end

 def move_forward
  return "No way forward.It is the last station" if @current_station == @route.route_stations[-1]
  move_train(next_station)
 end

 def move_back
  return "No way back.It is the first station" if @current_station == @route.route_stations[0]
  move_train(previous_station)
 end  
   
 def current_station
   @current_station
 end

 def previous_station
   @route.route_stations[current_station_index -1]
 end

 def next_station
  @route.route_stations[current_station_index +1]
 end
 
 private 
 
 def move_train(station)
  return unless @current_stations && @route.route_stations
  @current_station.send_train(self)
  station.accept_train(self)
  @current_station = station
 end 
 
 def current_station_index # this nethod is private since it is part of internal logic inside other methods and there is no need to use it separately
   @route.route_station.index(@current_station)
 end
 
end

class CargoWagon
  def initialize(volume,type)
   @volume = 44000
   @type = cargo
  end
end
