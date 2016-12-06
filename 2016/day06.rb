require 'canal'

puts STDIN.read.lines.map(&canal.strip.chars)
          .transpose
          .map(&canal.group_by(&canal)
                     .map{ |k, v| [v.size, k] }
                     .sort
                     # .reverse # uncomment for part 2
                     .last.last)
          .join
