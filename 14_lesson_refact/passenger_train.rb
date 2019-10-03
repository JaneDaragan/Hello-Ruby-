class PassengerTrain < Train

 def initialize(number)
    @type = 'passenger'
    super(number)
 end

 def add_wagon(wagon)
  return "Not appropriate wagon type" unless wagon.is_a?(PassengerWagon)
  super(wagon)
 end
end
