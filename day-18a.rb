require 'pry'

def until_space(chars)
  cs = []
  while chars.size > 0 && chars.first != " " && chars.first != "(" && chars.first != ")"
    cs.push(chars.shift)
  end
  cs
end

def parse_number(chars)
  num = ""
  while chars.size > 0 && chars.first != " " && chars.first != "(" && chars.first != ")"
    num += chars.shift
  end
  num.to_i
end

def parse(chars)
  lhs = if chars.first == ")"
          chars.shift
          parse(chars)
        else
          parse_number(chars)
        end
  if chars.first == "("
    chars.shift
    return lhs
  end
  return lhs if chars.size == 0
  chars.shift
  op = until_space(chars).first
  chars.shift
  rhs = parse(chars)
  [lhs, op, rhs]
end

def evaluate(ops)
  rhs = ops[0]
  unless rhs.is_a?(Integer)
    rhs = evaluate(ops[0])
  end
  op = ops[1]
  lhs = ops[2]
  unless lhs.is_a?(Integer)
    lhs = evaluate(ops[2])
  end
  case op
  when "+"
    rhs + lhs
  when "*"
    rhs * lhs
  end
end

lines = File.readlines('day-18-input.txt')

total = lines.sum do |line|
  parsed = parse(line.strip.reverse.chars)
  v = evaluate(parsed)
end

p total
