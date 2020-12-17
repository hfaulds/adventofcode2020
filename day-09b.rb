nums = File.readlines('day-9-input.txt').map(&:to_i)

invalid_num = nums[25..nums.size-1].each_with_index.find do |n, i|
  success = nums[i..(i+24)].any? do |x|
    nums[i..(i+24)].any? do |y|
      x + y == n
    end
  end
  if success
    nil
  else
    n
  end
end.first

(0..nums.size).each do |x|
  (x..nums.size).each do |y|
    range = nums[x..y]
    if range.sum == invalid_num
      p(range.min + range.max)
      exit
    end
  end
end
