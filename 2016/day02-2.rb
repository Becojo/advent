lines = STDIN.read.lines.map(&:strip)
x = 0
y = 2

board = ["  1  ",
         " 234 ",
         "56789",
         " ABC ",
         "  D  "].map(&:chars)

lines.each do |line|
  line.chars.each do |c|
    pos = [x, y]

    case c
    when 'U'
      y -= 1
    when 'D'
      y += 1
    when 'L'
      x -= 1
    when 'R'
      x += 1
    end

    if x < 0 || y < 0 || x >= 5 || y >= 5 || board[y][x] == ' '
      x, y = pos
    end
  end

  print board[y][x]
end

puts
