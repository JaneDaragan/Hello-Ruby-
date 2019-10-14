=begin Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:

Методы класса:

    instances, который возвращает кол-во экземпляров данного класса

Инстанс-методы:

    register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
=end



module InstanceCounter
  module ClassMethods

    attr_accessor :instances

      end

  module InstanceMethods

   private

   def register_instance
     self.class.instances ||=0
     self.class.instances +=1
   end
  end
end
