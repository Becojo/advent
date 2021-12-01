# frozen_string_literal: true

input =  File.read('4').split("\n\n").map do |pass|
  pass.split(/\s/).map { |field| field.split(':') }.to_h
end

fields = %w(
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
  cid
)

c = input.count do |pass|
  diff = fields - pass.keys
  diff.size == 0 || diff == %w(cid)
end

puts c

validations = {
  "byr" => ->(val) { (1920..2002).include?(val.to_i) },
  "iyr" => ->(val) { (2010..2020).include?(val.to_i) },
  "eyr" => ->(val) { (2020..2030).include?(val.to_i) },
  "hgt" => ->(val) {
    if val["cm"]
      (150..193).include?(val.to_i)
    else
      (59..76).include?(val.to_i)
    end
  },
  "hcl" => ->(val) { !val[/^#[a-f0-9]{6}$/i].nil? }, # val[/^#[a-f0-9]$/]{6}
  "ecl" => ->(val) { %w(amb blu brn gry grn hzl oth).include?(val) },
  "pid" => ->(val) { val[/^[0-9]{9}$/] },
  "cid" => ->(_) { true }
}

c = input.count do |pass|
  diff = fields - pass.keys - %w(cid)

  if diff.size == 0
    pass.all? do |key, value|
      validations[key].(value)
    end
  end
end

puts c
