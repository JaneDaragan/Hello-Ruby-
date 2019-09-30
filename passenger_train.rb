class PassengerTrain < Train
 def add_wagon(wagon)
  return "Not appropriate wagon type" unless wagon.is_a?(PassengerWagon)
  super(wagon)
 end
end
