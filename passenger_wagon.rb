class PassengerWagon < Wagon
 def initialize(type,seats_quantity)
   @seats_quantity = seats_quantity
   super(type)
 end
end
