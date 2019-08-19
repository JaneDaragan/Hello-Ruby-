class Station
 attr_reader :station_name
 attr_writer :trains
 def initialize(station_name)
   @station_name = station_name
 end

 def accept_train(train)
   @trains = []
   @trains << train
 end

 def trains_type(type)
   trains.select {|train| train.type == type}
 end

 def send_train(train)
   trains.delete(train)
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
   @stations.insert(-1, substation)
 end

 def delete_substation(substation)
   @stations.delete(substation) if substation.index !=0 ||substation.index !=-1
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
    @current_station = route.stations.first
  end

  def move_forward(route)
    @current_station.send_train(train)
    @route.stations.first(2).at(1).accept_train(train)
    @current_station =  @route.stations.first(2).at(1)
  end

  def move_back(route) # нужно написать позже по человечески 
    @current_station.send_train(train)
    index =  @route.route_stations.find_index(@current_station.station_name)
    @back_station = @route.route_stations(index -1) 
    @back_station.accept_train
    @current_station = back_station    
  end

  def current_station
    @current_station
  end

  def next_station(route)
    @route.route_stations.first(2).at(1)    #[current_index +1]
  end

  def previous_station
    index = @route.route_stations.find_index(@current_station.station_name)
    @previous_station = @route.route_stations(index -1)
  end
end
