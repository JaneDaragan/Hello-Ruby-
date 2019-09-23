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
 attr_reader :type,:number,:current_station,:route
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

 def take_route(route)
   @route = route
   @current_station = route.stations.first
   @current_station_index = 0
   current_station.accept_train(self)
   p 'Train took the route'
 end

 def previous_station
  return 'Error, no previous station it is the first station' if current_station == route.stations.first
  route.stations[current_station_index-1]
 end

 def next_station
  return 'Error, there is the final station' if current_station == route.stations.last
  route.stations[current_station_index+1]
 end

 def move_forward
  return "No way forward.It is the last station" if current_station == route.stations.last
  move_train(next_station)
  p "we moved to #{current_station.name}"
 end

 def move_back
  return "No way back.It is the first station" if current_station == route.stations.first
  move_train(previous_station)
  p "we moved to #{current_station.name}"
 end

 private
 # текущий индекс станции перенесен в секцию приватных методов для того чтобы избежать возможных ошибок со стороны пользователя во время движения, для сохранения логики движения, 
 attr_accessor :current_station_index
 # метод движение поезда перенесен в приватные методы для избавления кода от избыточного дублирования и реализации принципа инкапсуляции, оставить в интерфейсе класса, только необходимое.
 def move_train(station)
   return "There is no route" unless @current_station && @route.stations
   current_station.send_train(self)
   station.accept_train(self)
   self.current_station = station
   self.current_station_index = route.stations.index(station)
 end
end

class PassengerWagon
 def initialize(seats_quantity)
   @seats_quantity = seats_quantity
 end
end

class CargoTrain
 attr_reader :type, :current_station,:route
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
  @current_station = route.stations.first
  @current_station_index = 0
  current_station.accept_train(self)
 end

 def move_forward
  return "No way forward.It is the last station" if current_station == route.stations.last
  move_train(next_station)
  p "we moved to #{current_station.name}"
 end

 def move_back
  return "No way back.It is the first station" if current_station == route.stations.first
  move_train(previous_station)
  p "we moved to #{current_station.name}"
 end

 def previous_station
   route.stations[current_station_index-1]
 end

 def next_station
   route.stations[current_station_index+1]
 end

 private
 # this nethod is private since it is part of internal logic inside other methods and there is no need to use it sep
 attr_accessor :current_station_index

 def move_train(station)
  return "No route!" unless @current_station && @route.stations
  current_station.send_train(self)
  station.accept_train(self)
  self.current_station = station
  self.current_station_index = route.stations.index(station)
 end
end

class CargoWagon
  def initialize(volume)
   @volume = volume
  end
end

=begin описание как тестировался код в IRB
st1 = Station.new('Almaty')
st2 = Station.new('Karaganda')
st3 = Station.new('Astana')
route = Route.new(st1, st3)
train_pass = PassengerTrain.new(111, 'passenger')
train_cargo = CargoTrain.new(222, 'cargo')
wagon_cargo = CargoWagon.new(130, 'cargo')
wagon_passenger = PassengerWagon.new(52, 'passenger')

1) создаем 8 объектов экземпляров классов,
2) тестируем модель движения вперед и назад по маршруту
3) тестируем добавление грузового вагона к грузовому поезду
4) тестируем добавление грузового вагона к пассажирскому поезду
5) тестируем добавление пассажирского вагона к пассажирскому поезду
6) тестируем добавление пассажирского вагона к грузовому поезду

st1 = Station.new('Almaty')
st2 = Station.new('Karaganda')
st3 = Station.new('Astana')

route = Route.new(st1, st3)
route.add_substation(st2)
route.delete_substation(st2)

train_pass = PassengerTrain.new(111, 'passenger')
train_cargo = CargoTrain.new(222, 'cargo')

st1.accept_train(train_pass)
st1.send_train(train_pass)

wagon_cargo = CargoWagon.new(130,'cargo')
wagon_passenger = PassengerWagon.new(52, 'passenger')

train_pass.add_wagon(wagon_cargo)
train_pass.add_wagon(wagon_passenger)

train_pass.take_route(route)
train_pass.current_station
train_pass.move_forward
train_pass.move_back
train_pass.next_station
train_pass.previous_station

train_cargo.add_wagon(wagon_cargo)
train_cargo.add_wagon(wagon_passenger)

train_cargo.take_route(route)
train_cargo.current_station
train_cargo.move_forward
train_cargo.move_back
train_cargo.next_station
train_cargo.previous_station
=end
