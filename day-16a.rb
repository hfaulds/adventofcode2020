rules = []
errors = []

lines = File.readlines('day-16-input.txt')

line = lines.shift
until line == "\n"
  _, x_min, x_max, y_min, y_max = /([^:]+): (\d+)-(\d+) or (\d+)-(\d+)/.match(line).captures
  rules.push([[x_min.to_i, x_max.to_i], [y_min.to_i, y_max.to_i]])
  line = lines.shift
end

until line == "nearby tickets:\n"
  line = lines.shift
end

line = lines.shift
until line.nil?
  vals = line.strip.split(",").map(&:to_i)
  errors += vals.reject do |val|
    rules.any? do |((x_min, x_max), (y_min, y_max))|
      (val >= x_min && val <= x_max) ||
        (val >= y_min && val <= y_max)
    end
  end
  line = lines.shift
end

p errors.sum
