valid=0

File.readlines('day-2-input.txt').each do |line|
  a, b, pass = line.split(" ")

  x, y = a.split("-").map(&:to_i)
  char = b[0]

  if (pass.chars[x - 1] == char) ^  (pass.chars[y - 1] == char)
    valid+=1
  end
end

p valid
