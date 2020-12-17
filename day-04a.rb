REQUIRED_FIELDS=%w(byr iyr eyr hgt hcl ecl pid)

passports = File.readlines('day-4-input.txt').reduce([{}]) do |passports, line|
  if line.strip == ""
    passports.push({})
  else
    passport = passports.last
    line.split(" ").each do |kv|
      k,v = kv.split(":")
      passport[k] = v
    end
  end
  passports
end

valid = passports.count do |pass|
  REQUIRED_FIELDS.all? do |k|
    !pass[k].nil?
  end
end

p valid
