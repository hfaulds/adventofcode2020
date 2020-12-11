def surrounding_seats(state, x, y)
  (y-1..y+1).flat_map do |yy|
    if yy >= 0 && yy < state.size
      (x-1..x+1).map do |xx|
        if xx >= 0 && xx < state[yy].size && !(xx == x && yy == y)
          state[yy][xx]
        end
      end
    end
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
  p surrounding_seats(state, 0, 0)
  next_state = []

  state.each_with_index do |row, y|
    row.each_with_index do |seat, x|
      next_state[y] ||= []
      if seat == 'L' && !surrounding_seats(state, x, y).any? { |x| x == '#' }
        next_state[y][x] = '#'
      elsif seat == '#' && surrounding_seats(state, x, y).count { |x| x == '#' } >= 4
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
