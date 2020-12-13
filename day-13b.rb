lines = File.readlines('day-13-input.txt')
#lines = ["7,13,x,x,59,x,31,19"]
busses = lines.last.strip.split(",")

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'Multiplicative inverse modulo does not exist!'
  end
  x % et
end

def chinese_remainder(mods, remainders)
  max = mods.inject( :* )  # product of all moduli
  series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
  series.inject( :+ ) % max
end

busses_with_offset = busses.each_with_index.reject { |x,_| x == "x" }.map { |x, i| [x.to_i, (x.to_i - i) % x.to_i] }

p chinese_remainder(busses_with_offset.map(&:first), busses_with_offset.map(&:last))
