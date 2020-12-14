require 'pry'

def apply_mask(mask, val)
  mask = mask.chars
  val = val.chars

  num_xs =  mask.count { |x| x == "X" }
  x_combinations = (2 ** num_xs).times.map do |t|
    ('%0*b' % [num_xs, t]).chars
  end

  x_combinations.map do |xs|
    res = 36.times.map do |i|
      case mask[i]
      when "0"
        val[i]
      when "1"
        mask[i]
      when "X"
        xs.shift
      end
    end.join("").to_i(2)
  end
end

mem = {}
mask = ""

lines = File.readlines('day-14-input.txt')
lines.each do |line|
  cmd, val = line.strip.split(" = ")
  if cmd == "mask"
    mask = val
  elsif cmd.start_with? "mem"
    mem_loc = '%036b' % cmd.split("[").last.split("]").first.to_i
    mem_locs = apply_mask(mask, mem_loc)
    mem_locs.each do |m|
      mem[m] = val.to_i
    end
  end
end

p mem.values.sum
