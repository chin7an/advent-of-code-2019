fuel_req = 0
File.open("module_mass.txt").each do |mod|
  curr_fuel = Integer(mod)
  loop do
    break if curr_fuel == 0
    curr_fuel = if (calc = ((curr_fuel / 3).floor - 2)) > 0 then calc else 0 end
    fuel_req += curr_fuel
  end
end
puts fuel_req