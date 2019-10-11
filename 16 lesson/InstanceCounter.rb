=begin Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:

Методы класса:

    instances, который возвращает кол-во экземпляров данного класса

Инстанс-методы:

    register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
=end



module InstanceCounter
  module ClassMethods

    attr_accessor :instance_count

    def instances
      @@instance_count = 0
    end

  end

  module InstanceMethods

    attr_accessor :instance_count

    @@instance_count = 0

   def register_instance
     self.class.instance_count +=1
   end
  end
end
