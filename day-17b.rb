require 'pry'

string = "...#..#.
#..#...#
.....###
##....##
......##
........
.#......
##...#.."

state = string.split("\n").map(&:strip).map(&:chars).reverse.each_with_index.reduce({}) do |h, (row, y)|
  row.each_with_index do |cell, x|
    h[[x,y,0,0]] = true if cell == "#"
  end
  h
end

def nearby_count(state,x,y,z,w)
  (-1..1).sum do |dx|
    (-1..1).sum do |dy|
      (-1..1).sum do |dz|
        (-1..1).count do |dw|
          unless dx == 0 && dy == 0 && dz == 0 && dw == 0
            state[[x+dx,y+dy,z+dz,w+dw]]
          end
        end
      end
    end
  end
end

def next_state(state)
  xs = state.keys.map { |x| x[0] }
  ys = state.keys.map { |y| y[1] }
  zs = state.keys.map { |z| z[2] }
  ws = state.keys.map { |w| w[3] }
  new_state = {}
  (xs.min-1..xs.max+1).each do |x|
    (ys.min-1..ys.max+1).each do |y|
      (zs.min-1..zs.max+1).each do |z|
        (ws.min-1..ws.max+1).each do |w|
          active_neighbours = nearby_count(state,x,y,z,w)
          if state[[x,y,z,w]]
            if active_neighbours == 2 || active_neighbours == 3
              new_state[[x,y,z,w]] = true
            end
          else
            if active_neighbours == 3
              new_state[[x,y,z,w]] = true
            end
          end
        end
      end
    end
  end
  new_state
end

6.times do |i|
  state = next_state(state)
end

p state.keys.size
