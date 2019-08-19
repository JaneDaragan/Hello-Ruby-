class Station
 attr_reader :name, :trains
 def initialize(name,trains)
   @name = name
   @trains = []
 end

 def accept_train(train)
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
    @current_station = route.stations.first
  end

  def move_forward(route)
    return "Error" if @current_station = @stations(-1) 
    @current_station.send_train(self)
    @route.stations.first(2).at(1).accept_train(self)
    @current_station =  @route.stations.first(2).at(1)
  end

  def move_back(route)# нужно написать позже по человечески 
    return "Error" if @current_station = @stations(0) 
    @current_station.send_train(self)
    index =  @route.route_stations.find_index(@current_station)
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
    index = @route.route_stations.find_index(@current_station)
    @previous_station = @route.route_stations(index -1)
  end
end
