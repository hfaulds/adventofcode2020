require 'pry'
@directions = [
  [-1,-1],
  [0, -1],
  [1, -1],

  [-1, 0],
  [1,  0],

  [-1, 1],
  [0,  1],
  [1,  1],
]
def surrounding_seats(state, x, y)
  @directions.map do |(dx,dy)|
    xx = x
    yy = y
    seat = "."

    while (yy + dy >= 0) && (yy + dy < state.size) &&
        (xx + dx >= 0) && (xx + dx  < state[yy+dy].size) &&
        seat == "."
      xx += dx
      yy += dy
      seat = state[yy][xx]
    end

    seat == "." ? nil : seat
  end.compact
end

#state = "L.LL.LL.LL
#LLLLLLL.LL
#L.L.L..L..
#LLLL.LL.LL
#L.LL.LL.LL
#L.LLLLL.LL
#..L.L.....
#LLLLLLLLLL
#L.LLLLLL.L
#L.LLLLL.LL".split("\n").map(&:strip).map(&:chars)
state = File.readlines('day-11-input.txt').map(&:strip).map(&:chars)
prev_state = []

until state == prev_state do
  print state.map(&:join).join("\n") + "\n\n"
  next_state = []

  state.each_with_index do |row, y|
    row.each_with_index do |seat, x|
      next_state[y] ||= []
      if seat == 'L' && !surrounding_seats(state, x, y).any? { |x| x == '#' }
        next_state[y][x] = '#'
      elsif seat == '#' && surrounding_seats(state, x, y).count { |x| x == '#' } >= 5
        next_state[y][x] = 'L'
      else
        next_state[y][x] = seat
      end
    end
  end

  prev_state = state
  state = next_state
end

p state.sum { |row| row.count { |seat| seat == '#' } }
