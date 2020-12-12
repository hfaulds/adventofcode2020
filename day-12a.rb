DIRECTIONS=%w(N E S W)

@position=[0,0]
@direction="E"

def new_pos(command, amount)
  case command
  when "N"
    @position[1] += amount
  when "S"
    @position[1] -= amount
  when "E"
    @position[0] += amount
  when "W"
    @position[0] -= amount
  when "L"
    di = DIRECTIONS.find_index(@direction) - (amount / 90)
    @direction = DIRECTIONS[di % DIRECTIONS.size]
  when "R"
    di = DIRECTIONS.find_index(@direction) + (amount / 90)
    @direction = DIRECTIONS[di % DIRECTIONS.size]
  when "F"
    new_pos(@direction, amount)
  end
end

lines = File.readlines('day-12-input.txt')
lines.each do |line|
  line = line.strip
  command = line.chars.first
  amount =  line.chars[1..line.size-1].join("").to_i
  new_pos(command, amount)
end

p(@position[0].abs + @position[1].abs)
