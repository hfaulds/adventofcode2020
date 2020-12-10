require 'pry'
lines = File.readlines('day-10-input.txt')

@adaptors = lines.map(&:to_i).sort
@target = @adaptors.max + 3
@cache = {}

def recurse(last_val, last_index)
  return 1 if (@target - last_val) <= 3

  @adaptors[last_index+1..@adaptors.size-1].take_while do |a|
    a <= last_val + 3
  end.each_with_index.sum do |a, i|
    unless @cache[a]
      @cache[a] = recurse(a, last_index + i + 1)
    end
    @cache[a]
  end
end

p recurse(0, -1)
