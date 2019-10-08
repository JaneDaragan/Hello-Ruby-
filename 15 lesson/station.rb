class Station

 @@stations = []

 def self.all
   @@stations
 end

 attr_reader :name, :trains
 def initialize(name)
   @name = name
   @trains = []
   @@stations << self
 end

 def accept_train(train)
   @trains << train
 end

 def send_train(train)
   @trains.delete(train)
 end

 def trains_type(type)
   @trains.select {|train| train.type == type}
 end
end
