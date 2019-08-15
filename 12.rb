class Station
 attr_accessor :trains, :station_name
end
 def initialize(station_name)
   @station_name = station_name
  end

 def accept_train(train)
   @trains = []
   @trains << train
 end

 def trains
   @trains
 end

 def trains_type(type)
   trains.select {|train| train.type == type} #something wrong fix later

 def send_train(train)
   trains.delete(train)
 end
end

class Route
 attr_accessor :stations, :first, :last
end
 def initialize(first, last)
  @first = first
  @last = last
  @stations = [first, last]
 end

 def add_substation(substation)
   @stations.insert(1, substation)
 end

 def delete_substation(substation)
   @stations.delete(substation) # not sure but do not know how to check
 end

 def route_stations
   puts @stations # кажется лучше использовать puts
 end
end

class Train
 attr_accessor :type, :speed, :wagon_quantity, :route 
end
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
    @current_station = stations.station_list[0]
  end

  def move_forward
    @route.station_list[1] # опять какие то сомнения, как это будет работать уже в пути, когда он будет двигаться через substations
  end

  def move_back
    @route.station_list[-1] # и тут мне все не нравиться, чего то не хватает, так поезд попадет на конечную станцию ведь
  end

  def current_station
    @current_station
  end

  def next_station
    @route.station_list[1] #error need to update
  end

  def back_station
    @route.station_list[-1] #error but I can't find how to write it properly
  end
end
