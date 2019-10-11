

require_relative 'Manufacturer'
require_relative 'InstanceCounter'

class Train
 include Manufacturer
 include InstanceCounter
 extend InstanceCounter::ClassMethods
 include InstanceCounter::InstanceMethods

 attr_reader :type,:number,:current_station,:route, :wagons
 attr_writer :current_station
 def initialize(number)
   @number = number
   @wagons = []
   @speed = 0
   self.register_instance
 end

 def add_wagon(wagon)
   return "Error, first you need to stop the train" if @speed != 0
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
   p "Train took the route #{route.name}"
 end

 def previous_station
  return "Error, no previous station it is the first station" if current_station == route.stations.first
  route.stations[current_station_index-1]
 end

 def next_station
  return "Error, there is the final station" if current_station == route.stations.last
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

 attr_accessor :current_station_index

 def move_train(station)
   return "There is no route" unless @current_station && @route.stations
   current_station.send_train(self)
   station.accept_train(self)
   self.current_station = station
   self.current_station_index = route.stations.index(station)
 end
end
