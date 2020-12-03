grid = File.readlines('day-3-input.txt').map do |line, i|
  line.strip.chars
end

y=0
x=0

count=0

while grid[y] != nil
  if grid[y][x % grid[y].size] == "#"
    count += 1
  end
  y+=1
  x+=3
end

p count
