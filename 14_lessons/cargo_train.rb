require_relative 'train.rb'

class CargoTrain < Train

 def add_wagon(wagon)
  return "Not appropriate wagon type" unless wagon.is_a?(CargoWagon)
  super(wagon)
 end
end
