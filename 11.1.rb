class Station
 def initialize(station_name)
   @station_name = station_name
  end
end

class Route
 def initialize(station_name1, station_name2)
  @station_name1 = station_name1
  @station_name2 = station_name2
  @stations = [station_name1, station_name2]
 end

 def station_list
   @stations
 end
end

class Train
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

  def wagon_quantity
    @wagon_quantity
  end

  def add_wagon
    return "Error" if @speed != 0
    @wagon_quantity +=1
  end

  def delete_wagon
    return "Error" if @speed != 0
    @wagon_quantity -=1
  end
end
