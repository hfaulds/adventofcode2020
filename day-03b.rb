moves = [
  [1,1],
  [3,1],
  [5,1],
  [7,1],
  [1,2],
]

grid = File.readlines('day-3-input.txt').map do |line, i|
  line.strip.chars
end

result = moves.reduce(1) do |r, (dx,dy)|
  y=0
  x=0

  count=0

  while grid[y] != nil
    if grid[y][x % grid[y].size] == "#"
      count += 1
    end
    y+=dy
    x+=dx
  end

  r * count
end

p result
