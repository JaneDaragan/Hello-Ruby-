class Station
 attr_accessor :trains, :station_name
 def initialize(station_name)
   @station_name = station_name
 end

 def accept_train(train)
   @trains = []
   @trains << train
 end

 def trains_type(type)
   trains.select {|train| train.type == type} #something wrong fix later
 end

 def send_train(train)
   trains.delete(train)
 end
end

class Route
 attr_accessor :stations, :first, :last
 def initialize(first, last)
  @first = first
  @last = last
  @stations = [first, last]
 end

 def add_substation(substation)
   @stations.insert(1, substation)
 end

 def delete_substation(substation)
   @stations.delete(substation)
 end

 def route_stations
   puts @stations
 end
end

class Train
 attr_accessor :type, :speed, :wagon_quantity
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

  def take_route(stations)
    @route = stations
    @current_station = stations[0]
  end

  def move_forward(stations)
    @route[0].send_train(train)
    @route[1].accept_train(train)
    @current_station = stations[1] # опять какие то сомнения, как это будет работать уже в пути, когда он будет двигаться через substations
  end

  def move_back
    @route[0].send_train(train)
    @route[-1].accept_train(train) # здесь явно ошибка
    @current_station = @route[-1]
  end

  def current_station
    @current_station
  end

  def next_station
    @route[1] #не знаю кажется это неправльно
  end

  def previous_station
    @route[-1] # и здесь тоже
  end
end
