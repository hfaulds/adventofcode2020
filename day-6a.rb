groups = File.readlines('day-6-input.txt').reduce([[]]) do |groups, line|
  if line.strip == ""
    groups << []
  else
    group = groups.last
    new_group = (group + line.strip.chars).uniq
    groups.first(groups.size-1) + [new_group]
  end
end
p groups.map(&:size).sum
