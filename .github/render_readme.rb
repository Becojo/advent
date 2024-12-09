#!/usr/bin/env ruby

puts "Some solutions for the Advent of Code."
puts

Dir['*/*.*'].sort.reverse.group_by do |file|
  year, _ = file.split('/', 2)
  year
end.each do |year, files|
  puts "## #{year}"

  files.map do |file|
    file[/(\d+)-?(\d+)?\./]
    next unless $1
    day = $1.to_i
    part = $2&.to_i

    { day: day, part: part, path: file }
  end.compact.sort_by do |file|
    -file[:day]
  end.group_by do |file|
    file[:day]
  end.each do |day, files|
    puts "- Day #{day}"

    files.each do |file|
      next if file[:path][".run"]

      puts "    - [`#{file[:path]}`](#{file[:path]})"
    end
  end
end
