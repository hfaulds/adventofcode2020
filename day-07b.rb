def parse_rule(rule)
  match = rule.match(/^(\d+) (.*) bags?\.?$/)
  return unless match
  quantity, color = match.captures
  { color: color, quantity: quantity.to_i }
end

def recurse(rules, color)
  r = rules[color]
  r.map do |child|
    recurse(rules, child[:color]) * child[:quantity]
  end.sum + 1
end


lines = "shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags."

rules = File.readlines('day-7-input.txt').reduce({}) do |rules, line|
  parent, rule = line.split(" bags contain ")
  rule = rule.split(", ").map { |rule| parse_rule(rule) }.compact
  rules.merge(parent => rule)
end

p (recurse(rules, "shiny gold") - 1)
