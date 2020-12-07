NUM_ROWS=128
NUM_COLUMNS=8

POSSIBLE_SEATS = + NUM_COLUMNS..(((NUM_ROWS-1) * NUM_COLUMNS) + NUM_COLUMNS)

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
  (row * NUM_COLUMNS) + column
end

def find_my_seat(possible, occupied)
  (possible - occupied).find do |s|
    occupied.include?(s-1) &&
    occupied.include?(s+1)
  end
end

seat_ids = File.readlines('day-5-input.txt').map do |line|
  find_seat_id(line)
end

p find_my_seat(POSSIBLE_SEATS.to_a, seat_ids)
