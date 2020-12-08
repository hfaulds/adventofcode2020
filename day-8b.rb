def run(lines, accumulator, ran, i)
  if ran.include? i
    return [accumulator, false]
  end
  if i >= lines.size
    return [accumulator, true]
  end

  line = lines[i]
  instruction, arg = line.split(" ")
  val = arg.to_i
  case instruction
  when "nop"
    return run(lines, accumulator, ran + [i], i + 1)
  when "jmp"
    return run(lines, accumulator, ran + [i], i + val)
  when "acc"
    return run(lines, accumulator + val, ran + [i], i + 1)
  else
     raise "oops #{instruction}"
  end
end

lines = File.readlines('day-8-input.txt').map(&:strip).compact

lines.each_with_index do |line, i|
  instruction, arg = line.split(" ")
  val = arg.to_i
  new_lines = lines.dup
  case instruction
  when "nop"
    new_lines[i] = "jmp #{val}"
    accumulator, ok = run(new_lines, 0, [], 0)
    return p(accumulator) if ok
  when "jmp"
    new_lines[i] = "nop #{val}"
    accumulator, ok = run(new_lines, 0, [], 0)
    return p(accumulator) if ok
  end
end
