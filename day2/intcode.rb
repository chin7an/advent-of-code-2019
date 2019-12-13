codes = File.open("intcode.txt", &:readline).split(",").map(&:to_i)
# part1 modifications
codes[1] = 12
codes[2] = 2

pc = 0
while codes[pc] != 99
  inst = codes[pc, 4]
  res = inst[3]
  case inst[0]
  when 1
    codes[res] = codes[inst[1]] + codes[inst[2]]
  when 2
    codes[res] = codes[inst[1]] * codes[inst[2]]
  else
    raise "Invalid opcode read: #{codes[pc]}"
  end
  pc += 4
end
p codes