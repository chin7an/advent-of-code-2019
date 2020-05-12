module Fuel

  def fuel_counter(file)
    fuel_req = 0
    File.open(__dir__ + file).each do |mod|
      fuel_req += (Integer(mod) / 3).floor - 2
    end
    fuel_req
  end

  def rocket_equation(file)
    fuel_req = 0
    File.open(__dir__ + file).each do |mod|
      curr_fuel = Integer(mod)
      loop do
        break if curr_fuel.zero?

        curr_fuel = (calc = ((curr_fuel / 3).floor - 2)).positive? ? calc : 0
        fuel_req += curr_fuel
      end
    end
    fuel_req
  end

end
