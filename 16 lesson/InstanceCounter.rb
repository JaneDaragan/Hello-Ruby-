=begin Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:

Методы класса:

    instances, который возвращает кол-во экземпляров данного класса

Инстанс-методы:

    register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
=end



module InstanceCounter
  module ClassMethods

    attr_accessor :instance_count

  end

  module InstanceMethods

  self.class.instance_count = 0
      
   private

   def register_instance
     self.class.instances_count ||= 0  
     self.class.instance_count +=1
   end
  end
end
