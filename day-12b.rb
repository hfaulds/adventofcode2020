@waypoint=[10,1]
@position=[0,0]

def clockwise(pos)
  [pos[1], -pos[0]]
end

def anticlockwise(pos)
  [-pos[1], pos[0]]
end

def new_pos(command, amount)
  case command
  when "N"
    @waypoint[1] += amount
  when "S"
    @waypoint[1] -= amount
  when "E"
    @waypoint[0] += amount
  when "W"
    @waypoint[0] -= amount
  when "L"
    @waypoint = (amount / 90).times.reduce(@waypoint) { |p| anticlockwise(p) }
  when "R"
    @waypoint = (amount / 90).times.reduce(@waypoint) { |p| clockwise(p) }
  when "F"
    @position[0] += @waypoint[0] * amount
    @position[1] += @waypoint[1] * amount
  end
end

lines = File.readlines('day-12-input.txt')
lines.each do |line|
  line = line.strip
  command = line.chars.first
  amount =  line.chars[1..line.size-1].join("").to_i
  new_pos(command, amount)
end

p((@position[0].abs + @position[1].abs).to_i)
