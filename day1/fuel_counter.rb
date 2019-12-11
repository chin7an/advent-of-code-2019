fuel_req = 0
File.open("module_mass.txt").each do |mod|
  fuel_req += (Integer(mod) / 3).floor - 2
end
puts fuel_req