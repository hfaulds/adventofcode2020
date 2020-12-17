valid=0

File.readlines('day-2-input.txt').each do |line|
  a, b, pass = line.split(" ")

  min, max = a.split("-").map(&:to_i)
  char = b[0]

  counts = pass.chars.reduce({}) do |h, c|
    h[c] ||= 0
    h[c] += 1
    h
  end

  if counts[char] && counts[char] >= min && counts[char] <= max
    valid+=1
  end
end

p valid
