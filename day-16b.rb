rules = {}
my_ticket = []
valid_tickets = []

lines = File.readlines('day-16-input.txt')

line = lines.shift
until line == "\n"
  rule_name, x_min, x_max, y_min, y_max = /([^:]+): (\d+)-(\d+) or (\d+)-(\d+)/.match(line).captures
  rules[rule_name] = [[x_min.to_i, x_max.to_i], [y_min.to_i, y_max.to_i]]
  line = lines.shift
end

until line == "your ticket:\n"
  line = lines.shift
end

my_ticket = lines.shift.strip.split(",").map(&:to_i)

until line == "nearby tickets:\n"
  line = lines.shift
end

line = lines.shift
until line.nil?
  vals = line.strip.split(",").map(&:to_i)
  valid_ticket = vals.all? do |val|
    rules.values.any? do |((x_min, x_max), (y_min, y_max))|
      (val >= x_min && val <= x_max) ||
      (val >= y_min && val <= y_max)
    end
  end
  if valid_ticket
    valid_tickets.push(vals)
  end
  line = lines.shift
end


vals_at_columns = valid_tickets.reduce([]) do |a, vals|
  vals.each_with_index do |val, i|
    a[i] ||= []
    a[i].push(val)
  end
  a
end

columns_for_rules={}
rules.each do |rule_name, ((x_min, x_max), (y_min, y_max))|
  vals_at_columns.each_with_index do |vals, col|
    if vals.all? do |val|
      (val >= x_min && val <= x_max) ||
        (val >= y_min && val <= y_max)
      end
      columns_for_rules[rule_name] ||= []
      columns_for_rules[rule_name].push(col)
    end
  end
end

column_for_rules={}

cols_taken=[]
columns_for_rules.sort_by { |_,cols| cols.count }.each do |(rule_name, cols)|
  column_for_rules[rule_name] = (cols - cols_taken).first
  cols_taken += cols
end

output = 1
column_for_rules.each do |rule_name, col|
  if rule_name.start_with? "departure"
    output *= my_ticket[col]
  end
end

p output
