lines = File.readlines('day-13-input.txt')
timestamp = lines.first.to_i
busses = lines.last.strip.split(",")
buss_waits = busses.reject { |x| x == "x" }.map(&:to_i).map { |x|
  [x, (x - (timestamp % x))]
}
id, wait =  buss_waits.min_by(&:last)
p(id * wait)
