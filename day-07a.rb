def parse_rule(rule)
  match = rule.match(/^(\d+) (.*) bags?\.?$/)
  return unless match
  quantity, color = match.captures
  { color: color, quantity: quantity }
end

def recurse(rules, color)
  rule = rules[color]
  return false unless rule
  colors = rule.map { |r| r[:color] }
  return true if colors.include? "shiny gold"
  return colors.any? { |c| recurse(rules, c) }
end

rules = File.readlines('day-7-input.txt').reduce({}) do |rules, line|
  parent, rule = line.split(" bags contain ")
  rule = rule.split(", ").map { |rule| parse_rule(rule) }.compact
  rules.merge(parent => rule)
end

p(rules.keys.count { |starting_color| recurse(rules, starting_color) })
