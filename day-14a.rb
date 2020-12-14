def apply_mask(mask, val)
  mask = mask.reverse.chars
  val = val.reverse.chars
  res = 36.times.map do |i|
    mask[i] == "X" ? val[i] || "0" : mask[i]
  end.join("").reverse
  res.to_i(2)
end

mem = {}
mask = ""

lines = File.readlines('day-14-input.txt')
lines.each do |line|
  cmd, val = line.strip.split(" = ")
  if cmd == "mask"
    mask = val
  elsif cmd.start_with? "mem"
    mem_loc = cmd.split("[").last.split("]").first.to_i
    result = apply_mask(mask, val.to_i.to_s(2))
    mem[mem_loc] = result
  end
end

p mem.values.sum
