
require_relative 'Manufacturer'
require_relative 'InstanceCounter'

class Wagon
 include Manufacturer
 extend InstanceCounter::ClassMethods
 include InstanceCounter::InstanceMethods

 def initialize
  register_instance
 end
end
