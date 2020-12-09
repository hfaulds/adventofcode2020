nums = File.readlines('day-9-input.txt').map(&:to_i)

nums[25..nums.size-1].each_with_index.find do |n, i|
  success = nums[i..(i+24)].any? do |x|
    nums[i..(i+24)].any? do |y|
      x + y == n
    end
  end
  if !success
    p(n)
    return
  end
end
