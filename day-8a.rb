def run(lines, accumulator, ran, i)
  if ran.include? i
    return accumulator
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

p run(lines, 0, [], 0)
