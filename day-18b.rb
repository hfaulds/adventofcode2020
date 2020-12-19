lines = File.readlines('day-18-input.txt')

def process(chars)
  ops = []
  values = []

  chars.each do |char|
    next if char == " "
    case char
    when "+"
      ops.push(char)
    when "*"
      while ops.last == "+"
        ops.pop
        values.push(values.pop + values.pop)
      end
      ops.push("*")
    when "("
      ops.push(char)
    when ")"
      subchars = []
      until ops.last == "("
        subchars.unshift(values.pop)
        subchars.unshift(ops.pop)
      end
      subchars.unshift(values.pop)
      ops.pop
      values.push(process(subchars))
    else
      values.push(char.to_i)
    end
  end

  while ops.last == "+"
    ops.pop
    values.push(values.pop + values.pop)
  end

  values.reduce(:*)
end

p(lines.sum do |line|
  process(line.strip.chars)
end)
