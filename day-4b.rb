VALIDATIONS={
  "byr" => -> (x) { x && x.size == 4 && x.to_i >= 1920 && x.to_i <= 2002 },
  "iyr" => -> (x) { x && x.size == 4 && x.to_i >= 2010 && x.to_i <= 2020 },
  "eyr" => -> (x) { x && x.size == 4 && x.to_i >= 2020 && x.to_i <= 2030 },
  "hgt" => -> (x) { x && (
                      (x =~ /^\d+cm$/ && (x.split("cm").first.to_i >= 150 && x.split("cm").first.to_i <= 193)) ||
                      (x =~ /^\d+in$/ && (x.split("in").first.to_i >= 59 && x.split("in").first.to_i <= 76))
  ) },
  "hcl" => -> (x) { x && x =~ /^#[0-9a-f]{6}$/ },
  "ecl" => -> (x) { %w(amb blu brn gry grn hzl oth).include?(x) },
  "pid" => -> (x) { x && x =~ /^[0-9]{9}$/ },
}

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
  VALIDATIONS.all? do |(k,v)|
    v.call(pass[k])
  end
end

p valid
