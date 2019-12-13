fuel_req = 0
File.open("module_mass.txt").each do |mod|
  curr_fuel = Integer(mod)
  loop do
    break if curr_fuel == 0
    curr_fuel = (calc = ((curr_fuel / 3).floor - 2)) > 0 ? calc : 0
    fuel_req += curr_fuel
  end
end
puts fuel_req