values = []

File.readlines('day-1-input.txt').each do |line|
  values.push(line.to_i)
end

values.each do |x|
  values.each do |y|
    if (x + y) < 2020
      values.each do |z|
        if (x + y + z) == 2020
          p(x * y * z)
          exit
        end
      end
    end
  end
end
