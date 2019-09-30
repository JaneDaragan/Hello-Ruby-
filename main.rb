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
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

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

  def show_interface
   puts 'Введите - 1 чтобы создать станцию'
   puts 'Введите - 2 чтобы создать маршрут'
   puts 'Введите - 3 чтобы создать поезд'
   puts "Введите - 4 чтобы создать вагон"
   puts "Введите - 5 чтобы прицепить вагон к поезду"
   puts "Введите - 6 чтобы отцепить вагон от поезда"
   puts "Введите - 7 чтобы назначить маршрут поезду"
   puts "Введите - 8 чтобы отправить поезд на следующую станцию"
   puts "Введите - 9 чтобы отправить поезд на предыдущую станцию"
   puts "Введите -10 чтобы посмотреть список станций"
   puts "Введите -11 чтобы посмотреть список поездов на станции"
   puts "Введите - 0 чтобы выйти из программы"
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
     create_train
    when 4
     create_wagon
    when 5
     accept_wagon
    when 6
     remove_wagon
    when 7
     route_to_train
    when 8
     go_forward
    when 9
     go_back
    when 10
     list_stations
    when 11
     station_trains
   end
  end

  def create_station
   puts "Введите название станции"
   station_name = gets.chomp
   @stations << Station.new(station_name)
   p "станция #{station_name} создана"
  end

  def create_train
   puts "Выберите тип поезда: passenger - пассажирский, cargo - грузовой"
   train_type = gets.chomp
   puts "Введите номер поезда"
   train_number = gets.chomp.to_i
    if train_type == "passenger"
      @trains << PassengerTrain.new(train_number, train_type)
      p "создан пассажирский поезд"
    elsif train_type == "cargo"
      @trains << CargoTrain.new(train_number, train_type)
      p "создан грузовой поезд"
     else
      p "Для создания поезда не заданы атрибуты"
    end
  end

  def create_route
    if @stations.count >= 2
      puts "Введитe номер начальной станции из списка"
      @stations.each.with_index(1){|station,index| puts "#{index}. #{station.name}"}
      first = @stations[gets.chomp.to_i - 1]
      puts "Введите номер конечной станции из списка"
      last = @stations[gets.chomp.to_i - 1]
      @routes << Route.new(first, last)
      p "маршрут #{first.name}  #{last.name} создан"
    else
      puts "Для создания маршрута нужно создать как минимум 2 станции"
    end
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

  def accept_wagon
    puts "Выберите номер поезда, к которому нужно прицепить вагон из списка"
    @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
    puts "Упс, вначале нужно создать поезд, создайте его через меню нажав цифру - 3"  if @trains.empty?
    train = @trains[gets.chomp.to_i - 1]
    puts "Выберите номер вагона подходящего класса для поезда"
    @wagons.each.with_index(1){|wagon,index| puts "#{index}.#{wagon.class}"}
    puts "Вам нужно создать вагон, чтобы прицепить его" if @wagons.empty?
    wagon = @wagons[gets.chomp.to_i - 1]
    train.add_wagon(wagon)
    p "Поезд #{train.number} прицепил вагон"
  end

  def remove_wagon
   puts "Выберите номер поезда у которого нужно отцепить вагон"
   @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
   puts "Кажется вы еще не создали поезд, создайте его через меню вам нужно ввести цифру -3" if @trains.empty?
   train = @trains[gets.chomp.to_i - 1]
   puts "Выберите номер вагона, который нужно отцепить из списка"
   train.wagons.each.with_index(1){|wagon, index| puts "#{index}. #{wagon.class}"}
   wagon = train.wagons[gets.chomp.to_i - 1]
   train.delete_wagon(wagon)
   p "Поезд #{train.number} отцепил вагон"
  end

  def route_to_train
   puts "Введите номер поезда из предложенного списка"
   @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
   puts "Сначала нужно создать поезд" if @trains.empty?
   train = @trains[gets.chomp.to_i - 1]
   puts "Выберите номер маршрута из предложенного списка"
   @routes.each.with_index(1){|route, index| puts "#{index}. #{route.name}"}
   puts "Сначала нужно создать маршрут" if @routes.empty?
   route = @routes[gets.chomp.to_i - 1]
   train.take_route(route)
   p "Поезду #{train.number} назначен маршрут #{route.name}"
  end

  def go_forward
   puts "Введите номер поезда из предложенного списка"
   @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
   puts "Сначала нужно создать поезд" if @trains.empty?
   train = @trains[gets.chomp.to_i - 1]
   puts "Сначала нужно задать маршрут поезду" if train.route == nil
   train.move_forward
  end

  def go_back
   puts "Введите номер поезда из предложенного списка"
   @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
   puts "Сначала нужно создать поезд" if @trains.empty?
   train = @trains[gets.chomp.to_i - 1]
   puts "Сначала нужно задать маршрут поезду" if train.route == nil
   train.move_back
  end

  def list_stations
   puts "Нет созданных станций. Вначале создайте станции" if @stations.empty?
   @stations.each.with_index(1) {|station, index| puts "#{index}. #{station.name}"}
  end

  def station_trains
   puts "Вначале создайте станцию" if @stations.empty?
   puts "Выберите станцию из списка"
   list_stations
   station = @stations[gets.chomp.to_i - 1]
   puts "На станции нет поездов" if station.trains.empty?
   station.trains.each.with_index(1) {|train, index| puts "#{index}. #{train.class}"}
  end
end
app = App.new.start
