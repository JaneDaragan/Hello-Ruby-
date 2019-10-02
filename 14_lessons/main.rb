=begin
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
    Создавать станции
    Создавать поезда
    Создавать маршруты и управлять станциями в нем (добавлять, удалять)
    Назначать маршрут поезду
    Добавлять вагоны к поезду
    Отцеплять вагоны от поезда
    Перемещать поезд по маршруту вперед и назад
    Просматривать список станций и список поездов на станции
    как должна выглядить main
=end
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class App
  attr_reader :choice
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def start
    loop do
     show_interface
     @choice = get_choice
     break if choice == 0
     process_choices
   end
  end

  private

  def show_interface
   puts "Введите - 1, чтобы создать станцию"
   puts "Введите - 2, чтобы создать маршрут"
   puts "Введите - 3, чтобы добавить станцию в маршрут"
   puts "Введите - 4, чтобы удалить станцию из маршрута"
   puts "Введите - 5, чтобы создать поезд"
   puts "Введите - 6, чтобы создать вагон"
   puts "Введите - 7, чтобы прицепить вагон к поезду"
   puts "Введите - 8, чтобы отцепить вагон от поезда"
   puts "Введите - 9, чтобы назначить маршрут поезду"
   puts "Введите - 10,чтобы  отправить поезд на следующую станцию"
   puts "Введите - 11,чтобы отправить поезд на предыдущую станцию"
   puts "Введите - 12,чтобы посмотреть список станций"
   puts "Введите - 13,чтобы посмотреть список поездов на станции"
   puts "Введите - 0  выйти из программы"
  end

  def get_choice
   gets.chomp.to_i
  end

  def process_choices
   case choice
    when 1
     create_station
    when 2
     create_route
    when 3
      add_station
    when 4
      delete_station
    when 5
     create_train
    when 6
     create_wagon
    when 7
     accept_wagon
    when 8
     remove_wagon
    when 9
     route_to_train
    when 10
     go_forward
    when 11
     go_back
    when 12
     list_stations
    when 13
     station_trains
    end
  end

  def create_station
   puts "Введите название станции"
   name = gets.chomp
   @stations << Station.new(name)
   p "станция #{name} создана"
  end

  def create_train
   puts "Введите номер поезда"
   train_number = gets.chomp.to_i
   puts "Выберите тип поезда: passenger - пассажирский, cargo - грузовой"
   train_type = gets.chomp
    case train_type
    when 'passenger'
    @trains << PassengerTrain.new(train_number,train_type)
    p "создан пассажирский поезд"

    when 'cargo'
    @trains << CargoTrain.new(train_number,train_type)
    p "создан грузовой поезд"
    end
  end

  def create_route
    return puts "Вначале вам нужно создать 2 станции" if @stations.count < 2

    puts "Введитe номер начальной станции из списка"
    @stations.each.with_index(1){|station,index| puts "#{index}. #{station.name}"}
    first = @stations[gets.chomp.to_i - 1]

    puts "Введите номер конечной станции из списка"
    last = @stations[gets.chomp.to_i - 1]
    @routes << Route.new(first, last)
    p "маршрут #{Route.name} создан"
  end

  def add_station
    select_route
    list_stations
    @route.add_substation(@station)
    p "маршрут принял станцию"
  end

  def delete_station
    select_route
    p 'выберите станцию, которую нужно удалить из маршрута'
    @route.stations.each.with_index(1) {|station, index| puts "#{index}. #{station.name}"}
    @station = @route.stations[gets.chomp.to_i - 1]
    @route.stations.delete(@station)
    p "маршрут удалил станцию"
  end

  def create_passenger_wagon
   puts "Выберите какое количество мест будет у вагона из предложенных 54, 38 или 36"
   seats_quantity = gets.chomp
   @wagons << PassengerWagon.new(seats_quantity)
   p "Пассажирский вагон создан"
  end

  def create_cargo_wagon
   puts "Выберите какой объем будет грузового вагона выберите один из предложенных 120, 114, 138"
   volume = gets.chomp
   @wagons << CargoWagon.new(volume)
   p "Грузовой вагон создан"
  end

  def create_wagon
   puts "Выберите тип вагона passenger - пассажирский, cargo - грузовой"
    type = gets.chomp.to_s
    if type == "passenger"
      puts "Выберите какое количество мест будет у вагона из предложенных 54, 38 или 36"
      seats_quantity = gets.chomp.to_i
      @wagons << PassengerWagon.new(type,seats_quantity)
      p "Пассажирский вагон создан"
    elsif type == "cargo"
      puts "Выберите какой объем будет грузового вагона выберите один из предложенных 120, 114, 138"
      volume = gets.chomp.to_i
      @wagons << CargoWagon.new(type,volume)
      p "Грузовой вагон создан"
    else "Для создания вагона нужно указать основные параметры"
    end
  end

  def select_train
   puts "Введите номер поезда из предложенного списка"
   @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
   puts "Сначала нужно создать поезд" if @trains.empty?
   @train = @trains[gets.chomp.to_i - 1]
  end

  def select_wagon
   puts "Выберите номер вагона подходящего класса для поезда"
   @wagons.each.with_index(1){|wagon,index| puts "#{index}.#{wagon.class}"}
   return puts "Вам нужно создать вагон, чтобы прицепить его"  if @wagons.empty?
   @wagon = @wagons[gets.chomp.to_i - 1]
  end

  def select_route
    return puts "Сначала нужно создать маршрут"  if @routes.empty?
    puts "Выберите номер маршрута из предложенного списка"
    @routes.each.with_index(1){|route, index| puts "#{index}. #{route.name}"}
    @route = @routes[gets.chomp.to_i - 1]
  end

  def accept_wagon
   select_train
   select_wagon
   @train.add_wagon(@wagon)
   p "Поезд #{@train.number} прицепил вагон"
  end

  def remove_wagon
   select_train
   puts "Выберите номер вагона, который нужно отцепить из списка"
   @train.wagons.each.with_index(1){|wagon, index| puts "#{index}. #{wagon.class}"}
   wagon = @train.wagons[gets.chomp.to_i - 1]
   @train.delete_wagon(wagon)
   p "Поезд #{@train.number} отцепил вагон"
  end

  def route_to_train
   select_train
   return puts "Сначала нужно создать маршрут"  if @routes.empty?

   puts "Выберите номер маршрута из предложенного списка"
   @routes.each.with_index(1){|route, index| puts "#{index}. #{route.name}"}
   route = @routes[gets.chomp.to_i - 1]
   @train.take_route(route)
   p "Поезду #{@train.number} назначен маршрут #{Route.name} "
  end

  def go_forward
   select_train
   return puts "Сначала нужно задать маршрут поезду" if @train.route == nil
   @train.move_forward
  end

  def go_back
   select_train
   return puts "Сначала нужно задать маршрут поезду" if @train.route == nil
   @train.move_back
  end

  def list_stations
   return puts "Нет созданных станций. Вначале создайте станции"  if @stations.empty?
   puts "Выберите из списка существующих станций номер нужной вам станции"
   @stations.each.with_index(1) {|station, index| puts "#{index}. #{station.name}"}
   @station = @stations[gets.chomp.to_i - 1]
  end

  def station_trains
   list_stations
   return puts "На станции нет поездов"  if @station.trains.empty?
   @station.trains.each.with_index(1) {|train, index| puts "#{index}. #{train.class}"}
  end
end

app = App.new.start
