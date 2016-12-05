input = STDIN.read.lines

sum = 0
input.each do |line|
  checksum = line[/\[([a-z]*)\]/, 1]

  x = line[/([a-z\-]*)/,1].gsub('-','').chars
        .group_by { |x| x }
        .map { |k, v| [k, v.size] }
        .sort_by { |(char,freq)| [-freq, char]}
        .map(&:first)
        .join

  if x.start_with? checksum
    sum += line[/(\d+)/, 1].to_i
  end

end

puts sum

input.each do |line|
  n = line[/(\d+)/, 1].to_i
  shift = ('a'..'z').cycle.lazy.drop(n).take(26).to_a.join

  shifted = line.gsub('-', ' ').tr(('a'..'z').to_a.join, shift)

  puts n if shifted['north']
end
