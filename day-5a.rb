NUM_ROWS=128
NUM_COLUMNS=8

def find_binary_space(encoded, space, forward)
  encoded.reduce(space) do |s, char|
    if char == forward
      s.first(s.size/2)
    else
      s.last(s.size/2)
    end
  end.first
end

def find_seat_id(line)
  chars = line.strip.chars
  row = find_binary_space(chars.first(7), 0..NUM_ROWS-1, "F")
  column = find_binary_space(chars.last(3), 0..NUM_COLUMNS-1, "L")
  (row * 8) + column
end

seat_ids = File.readlines('day-5-input.txt').map do |line|
  find_seat_id(line)
end

p seat_ids.max
