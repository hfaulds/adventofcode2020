lines = File.readlines('day-10-input.txt')

adaptors = lines.map(&:to_i).sort
jolts = adaptors.each_with_index.reduce({}) do |jolts, (a,i)|
  b = adaptors[i+1]
  if b
    j = b - a
    jolts[j] ||= 1
    jolts[j] += 1
  end
  jolts
end
p(jolts[1] * jolts[3])
