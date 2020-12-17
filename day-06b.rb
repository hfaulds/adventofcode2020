groups = File.readlines('day-6-input.txt').reduce([[]]) do |groups, line|
  if line.strip == ""
    groups << []
  else
    new_group = groups.last
    new_group.push(line.strip.chars)
    groups.first(groups.size-1) + [new_group]
  end
end.map do |group|
  group.reduce(:&)
end
p groups.map(&:size).sum
