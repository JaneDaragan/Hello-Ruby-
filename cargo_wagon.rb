
class CargoWagon < Wagon
  def initialize(type,volume)
   @volume = volume
   super(type)
  end
end
