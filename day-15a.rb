require 'pry'

initial_numbers = [8,11,0,19,1,2]
numbers_spoken = {}
initial_numbers.each_with_index do |x, i|
  numbers_spoken[x] = [i+1]
end

last_spoken = initial_numbers.last
(initial_numbers.size+1..30000000).each do |i|
  if numbers_spoken[last_spoken] && numbers_spoken[last_spoken].size > 1
    last_spoken = numbers_spoken[last_spoken].last - numbers_spoken[last_spoken].last(2).first
  else
    last_spoken = 0
  end
  numbers_spoken[last_spoken] ||= []
  numbers_spoken[last_spoken].push(i)
end

p last_spoken
