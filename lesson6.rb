
def ask(string)

  puts "Wrong argument" unless string.class == String
  case string.class == String
  when string == "time"
    puts Time.now.strftime("%H:%M")
  when string == "date"
    puts Time.now.strftime("%d:%m:%Y")
  when string == "day"
    puts Time.now.strftime("%A")
  when string == "remaining weeks"
    remaining_weeks = 53 - Time.now.strftime("%W").to_i
     p remaining_weeks
   when string == "remaining days"
    remaining_days = 365 - Time.now.strftime("%j").to_i # пока не знаю как быть с високосным годом
     p remaining_days
   else
     p "Error in argument"
  end
end
