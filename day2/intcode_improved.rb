REGISTER = File.open("intcode.txt", &:readline).split(",").map(&:to_i)

def process(codes, noun, verb)
  codes[1] = noun
  codes[2] = verb

  pc = 0 # program counter
  while codes[pc] != 99
    case codes[pc]
    when 1  # addition
      inst = codes[pc, 4]
      res = inst[3]
      codes[res] = codes[inst[1]] + codes[inst[2]]
    when 2  # multiplication
      inst = codes[pc, 4]
      res = inst[3]
      codes[res] = codes[inst[1]] * codes[inst[2]]
    else # invalid code
      raise "Invalid opcode read: #{codes[pc]}"
    end
    pc += 4
  end
  codes[0]
end

loop do
  (0..99).each do |op1|
    (0..99).each do |op2|
      codes_copy = REGISTER.clone
      res = process(codes_copy, op1, op2)
      if res == 19_690_720
        puts "noun: #{op1}, verb: #{op2}"
        puts "answer: #{100 * op1 + op2}"
        exit
      end
    end
  end
end