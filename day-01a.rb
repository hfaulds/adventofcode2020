values = {
  0 => [],
  1 => [],
  2 => [],
  3 => [],
  4 => [],
  5 => [],
  6 => [],
  7 => [],
  8 => [],
  9 => [],
}

File.readlines('day-1-input.txt').each do |line|
  value = line.to_i
  last_digit = value % 10

  values[(0 - last_digit).abs].each do |potential_match|
    if (potential_match + value) == 2020
      p(potential_match * value)
      exit
    end
  end

  values[last_digit].push(value)
end
