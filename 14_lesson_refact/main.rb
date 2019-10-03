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
   puts " Enter - 1, to create station"
   puts " Enter - 2, to create route"
   puts " Enter - 3, to add station to route"
   puts " Enter - 4, to delete station from route"
   puts " Enter - 5, to create train"
   puts " Enter - 6, to create wagon"
   puts " Enter - 7, to accept wagon to train"
   puts " Enter - 8, to delete wagon from train"
   puts " Enter - 9, to asign route to train"
   puts " Enter - 10,to send train to the next station"
   puts " Enter - 11 to send train to the previous station"
   puts " Enter - 12,to show list of stations"
   puts " Enter - 13,to show list of station's trains"
   puts " Enter 0 to exit "
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
     list_stations(route = nil,@message)
    when 13
     station_trains
    end
  end

  def create_station
   puts "Enter station's name"
   name = gets.chomp
   station = Station.new(name)
   @stations << station
   p "Station #{station.name} created"
  end

  def create_train
   puts "Enter train's number"
   number = gets.chomp.to_i

   puts " Choose train's type: passenger, cargo"
   train_type = gets.chomp.to_s

   train_type == 'passenger'? create_passenger_train(number) : create_cargo_train(number)
  end

  def create_passenger_train(number)
    @trains << PassengerTrain.new(number)
    p "passenger train created"
  end

  def create_cargo_train(number)
    @trains << CargoTrain.new(number)
    p "cargo train created"
  end

  def create_route
    return puts "First you need to create at least 2 stations" if @stations.count < 2

    list_stations("Enter number of first station")
    first = @station

    list_stations("Enter number of the last station")
    last = @station

    route = Route.new(first, last)
    @routes << route
    p "route #{route.name} created"
  end

  def add_station
    select_route
    list_stations("select number of station for the list")
    @route.add_substation(@station)
    p "route accepted station"
  end

  def delete_station
    select_route
    p "select number of station you want to delete"
    @route.stations.each.with_index(1) {|station, index| puts "#{index}. #{station.name}"}
    @station = @route.stations[gets.chomp.to_i - 1]
    @route.stations.delete(@station)
    p " #{@route.name} deleted station #{@station.name}"
  end

  def create_passenger_wagon
   puts "Choose amount of seats quantity from the provided options: 54, 38 or 36"
   seats_quantity = gets.chomp.to_i
   @wagons << PassengerWagon.new(seats_quantity)
   p "Passenger wagon created"
  end

  def create_cargo_wagon
   puts "Shoose amount of volume for cargo wagon from the options: 120, 114, 138"
   volume = gets.chomp.to_f
   @wagons << CargoWagon.new(volume)
   p "Cargo wagon created"
  end

  def create_wagon
   puts "Shoose type of wagon passenger, cargo"
   type = gets.chomp.to_s
   return puts "For creating wagon need to provide parameters" if type.nil?
   type == "passenger"? create_passenger_wagon : create_cargo_wagon
  end

  def select_train
   puts "Enter number of train from provided list"
   @trains.each.with_index(1){|train, index| puts "#{index}. #{train.class}"}
   puts "First you need to create train" if @trains.empty?
   @train = @trains[gets.chomp.to_i - 1]
  end

  def select_wagon
   return puts "You need to create wagon first, in order to accept it to the train"  if @wagons.empty?
   puts "Enter number of apropriate wagon for the train"
   @wagons.each.with_index(1){|wagon,index| puts "#{index}.#{wagon.class}"}
   @wagon = @wagons[gets.chomp.to_i - 1]
  end

  def select_route
    return puts "First you need to create route"  if @routes.empty?
    puts "Enter number of route from the list"
    @routes.each.with_index(1){|route, index| puts "#{index}. #{route.name}"}
    @route = @routes[gets.chomp.to_i - 1]
  end

  def accept_wagon
   select_train
   select_wagon
   @train.add_wagon(@wagon)
   p "Train #{@train.number} accepted wagon"
  end

  def remove_wagon
   select_train
   puts "Select number of wagon to remove from the train"
   @train.wagons.each.with_index(1){|wagon, index| puts "#{index}. #{wagon.class}"}
   wagon = @train.wagons[gets.chomp.to_i - 1]
   @train.delete_wagon(wagon)
   p "Train #{@train.number} deleted wagon"
  end

  def route_to_train
   select_train
   select_route

   @train.take_route(@route)
   p "Train #{@train.number} has taken route #{@route.name} "
  end

  def go_forward
   select_train
   return puts "First you need to asign route to the train" if @train.route == nil
   @train.move_forward
  end

  def go_back
   select_train
   return puts "First you need to asign route to the train" if @train.route == nil
   @train.move_back
  end

  def list_stations(route = nil,message)
   return puts "There are no stations,first you need create stations"  if @stations.empty?
   @message = "list of existing stations"
   puts message
   @stations.each.with_index(1) {|station, index| puts "#{index}. #{station.name}"}
   @station = @stations[gets.chomp.to_i - 1]
  end

  def station_trains
   list_stations("Choose from the list of stations number of station")
   return puts "There is no trains at station"  if @station.trains.empty?
   @station.trains.each.with_index(1) {|train, index| puts "#{index}. #{train.class}"}
  end
end

app = App.new.start
