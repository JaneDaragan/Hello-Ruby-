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

 def stations
   @stations
 end
end

class PassengerTrain
 attr_reader :type,:number,:current_station
 attr_writer :current_station

 def initialize(number,type)
   @number = number
   @type = type
   @wagons = []
   @speed = 0
 end

 def add_wagon(wagon)
   return "Error, first you need to stop the train" if @speed != 0
   return "Not appropriate wagon type" unless wagon.is_a?(PassengerWagon)
   @wagons << wagon
 end

 def delete_wagon(wagon)
   return "Error" if @speed != 0
   @wagons.delete(wagon)
 end

 def take_route(route) #check it
   @route = route
   @current_station = @route.stations.first
   @current_station_index = 0
   current_station.accept_train(self)
   p 'Train took the route'
 end

 def previous_station
  return 'Error, no previous station it is the first station' if current_station_index == 0
  @route.stations[current_station_index -1]
 end

 def next_station
  return 'Error, there is the final station' if current_station_index == @route.stations.last
  @route.stations[current_station_index +1]
 end

 def move_forward
  return "No way forward.It is the last station" if current_station_index == @route.stations.last
  move_train(next_station)
  p "we moved to #{current_station.name}"
 end

 def move_back(previous_station)
  return "No way back.It is the first station" if current_station_index == @route.stations.first
  move_train(previous_station)
  p "we moved to #{current_station.name}"
 end

 private

 attr_accessor :current_station_index

 def move_train(station)
   return "There is no route" unless @current_station && @route.stations
   current_station.send_train(self)
   station.accept_train(self)
   current_station = @station
   @current_station_index = @route.stations.index(station)
 end
end

class PassengerWagon
 def initialize(seats_quantity)
   @seats_quantity = seats_quantity
 end
end

class CargoTrain
 attr_reader :type, :current_station
 attr_writer :current_station
 def initialize(number, type)
   @number = number
   @type = type
   @wagons = []
   @speed = 0
 end

 def add_wagon(wagon)
  return "Error, first you need to stop the train" if @speed != 0
  return "Not appropriate type of wagon!" unless wagon.is_a?(CargoWagon)
  @wagons << wagon
 end

 def delete_wagon(wagon)
  return "Error" if @speed != 0
  @wagons.delete(wagon)
 end

 def take_route(route)
  @route = route
  @current_station = @route.stations.first
  @current_station_index = @route.stations.index(current_station)
  current_station.accept_train(self)
 end

 def move_forward
  return "No way forward.It is the last station" if current_station_index == @route.stations.last
  move_train(next_station)
  p "we moved to #{@current_station.name}"
 end

 def move_back
  return "No way back.It is the first station" if current_station_index == @route.stations.first
  move_train(previous_station)
  p "we moved to #{@current_station.name}"
 end

  def previous_station
   @route.stations[current_station_index -=1]
 end

 def next_station
   @route.stations[current_station_index +=1]
 end

 private

 attr_accessor :current_station_index # this nethod is private since it is part of internal logic inside other methods and there is no need to use it sep

 def move_train(station)
  return "No route!" unless @current_station && @route.stations
  current_station.send_train(self)
  station.accept_train(self)
  current_station = station
  current_station_index = @route.stations.index(station)
 end
end

class CargoWagon
  def initialize(volume)
   @volume = volume
  end
end
