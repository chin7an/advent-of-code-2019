module IntCode

  def int_code(file)
    codes = File.open(__dir__ + file, &:readline).split(',').map(&:to_i)
    if file =~ /intcode/
      # part1 modifications
      codes[1] = 12
      codes[2] = 2
    end

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
    codes
  end

  def int_code_improved(file)
    register = File.open(__dir__ + file, &:readline).split(",").map(&:to_i)

    loop do
      (0..99).each do |op1|
        (0..99).each do |op2|
          codes_copy = register.clone
          res = process(codes_copy, op1, op2)
          next unless res == 19_690_720

          output = <<~END
            noun: #{op1}, verb: #{op2}
            answer: #{100 * op1 + op2}
          END
          return output
        end
      end
    end
  end

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

end