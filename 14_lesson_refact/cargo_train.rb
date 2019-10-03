
class CargoTrain < Train
  def initialize(number)
    @type = 'cargo'
    super(number)
  end   

 def add_wagon(wagon)
  return "Not appropriate wagon type" unless wagon.is_a?(CargoWagon)
  super(wagon)
 end
end
