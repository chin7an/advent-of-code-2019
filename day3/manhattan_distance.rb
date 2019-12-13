class Integer
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end

wires = []
File.open("wires.txt").each_with_index do |trace, idx|
  wires[idx] = trace.strip.split(",")
end

trace_row = {}
trace_col = {}
curr_x = curr_y = 0
wires[0].each do |move|
  direction = move[0]
  steps = Integer(move[1..])
  case direction
  when 'R', 'L'
    if direction == 'R'
      new_y = (curr_y + steps)
      trace_row[curr_x] = (curr_y..new_y)
    else
      new_y = (curr_y - steps)
      trace_row[curr_x] = (new_y..curr_y)
    end
    curr_y = new_y  # Read up on ruby variable scopes
  when 'U', 'D'
    if direction == 'U'
      new_x = (curr_x + steps)
      trace_col[curr_y] = (curr_x..new_x)
    else
      new_x = (curr_x - steps)
      trace_col[curr_y] = (new_x..curr_x)
    end
    curr_x = new_x
  end
end

curr_x = curr_y = 0
min_distance = Integer::MAX
wires[1].each do |move|
  direction = move[0]
  steps = Integer(move[1..])
  case direction
  when 'R', 'L'
    if direction == 'R'
      new_y = (curr_y + steps)
      col_r = (curr_y..new_y)
    else
      new_y = (curr_y - steps)
      col_r = (new_y..curr_y)
    end
    col_r.each do |col|
      if trace_col[col] && trace_col[col].include?(curr_x)
        if curr_x != 0 && col != 0
            curr_distance = curr_x.abs + col.abs
          min_distance = [min_distance, curr_distance].min
        end
      end
    end
    curr_y = new_y
  when 'U', 'D'
    if direction == 'U'
      new_x = (curr_x + steps)
      row_r = (curr_x..new_x)
    else
      new_x = (curr_x - steps)
      row_r = (new_x..curr_x)
    end
    row_r.each do |row|
      if trace_row[row] && trace_row[row].include?(curr_y)
        if row != 0 && curr_y != 0
          curr_distance = row.abs + curr_y.abs
          min_distance = [min_distance, curr_distance].min
        end
      end
    end
    curr_x = new_x
  end
end
p min_distance