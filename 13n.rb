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
 attr_reader :type,:number,:current_station, :current_station_index
 attr_writer :current_station, :current_station_index
 def initialize(number,type)
   @number = number
   @type = type
   @wagons = []
   @speed = 0
   @current_station_index = nil
 end

 def add_wagon(wagon)
   return "Error, first you need to stop the train" if @speed != 0
   return "Not appropriate wagon type" if wagon.is_a?(CargoWagon)
   @wagons << wagon
 end

 def delete_wagon(wagon)
   return "Error" if @speed != 0
   @wagons.delete(wagon)
 end

 def take_route(route) #check it
   @route = route
   @current_station = @route.stations[0]
   current_station_index = 0
   current_station.accept_train(self)
   p 'Train took the route'
 end

 def current_station # need to check this piece  of code
   @route.stations[current_station_index]
 end

 def previous_station
   @route.stations[current_station_index-1]
 end

 def next_station
   @route.stations[current_station_index+1]
 end

 def move_forward
  return "No way forward.It is the last station" if current_station_index == -1
  return "There is no route" unless @current_station && @route.stations
  current_station.send_train(self)
  next_station.accept_train(self)
  @current_station_index += 1
  @current_station = next_station
  p "we moved to #{current_station.name}"
 end

 def move_back
  return "No way back.It is the first station" if current_station_index == 0
  return "There is no route" unless @current_station && @route.stations
  current_station.send_train(self)
  previous_station.accept_train(self)
  @current_station_index -= 1
  @current_station = previous_station
  p "we moved to #{current_station.name}"
 end
end

class PassengerWagon
 def initialize(seats_quantity,type)
   @seats_quantity = seats_quantity
   @type = typeS
 end
end

class CargoTrain
 attr_reader :type, :current_station, :current_station_index
 attr_writer :current_station, :current_station_index
 def initialize(number, type)
   @number = number
   @type = type
   @wagons = []
   @speed = 0
   @current_station_index = nil
 end

 def add_wagon(wagon)
  return "Error, first you need to stop the train" if @speed != 0
  return "Not appropriate type of wagon!" if wagon.is_a?(PassengerWagon)
  @wagons << wagon
 end

 def delete_wagon(wagon)
  return "Error" if @speed != 0
  @wagons.delete(wagon)
 end

 def take_route(route)
   @route = route
   @current_station = @route.stations[0]
   @current_station_index = 0
   @current_station.accept_train(self)
 end

 def move_forward
  return "No way forward.It is the last station" if @current_station_index == -1
  self.move_train(next_station)
  p "we moved to #{@current_station.name}"
 end

 def move_back
  return "No way back.It is the first station" if @current_station_index == 0
  self.move_train(previous_station)
  p 'move back'
 end

 def current_station
   @route.stations[current_station_index(station)]
 end

 def previous_station
   @route.stations[current_station_index -1]
 end

 def next_station
   @route.stations[current_station_index +1]
 end

 private

 def current_station_index # this nethod is private since it is part of internal logic inside other methods and there is no need to use it separately
   @route.stations.index(station)
end

 def move_train(station)
  return "No route!" unless @current_station && @route.stations
  @current_station.send_train(self)
  station.accept_train(self)
  @current_station = station
 end
end

class CargoWagon
  def initialize(volume, type)
   @volume = volume
   @type = type
  end
end
