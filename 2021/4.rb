require 'canal'

input = File.readlines('4')

draws = input.shift.split(',').map(&:to_i)

class Board
  attr_reader :cols, :rows

  def initialize(values)
    @cols = []
    @rows = []
    @positions = {}

    5.times do |x|
      row = []
      col = []

      5.times do |y|
        row_value = values[x * 5 + y]
        col_value = values[y * 5 + x]
        row << row_value
        col << col_value

        @positions[row_value] = [x, y]
      end

      @rows << row
      @cols << col
    end
  end

  def draw(value)
    return unless @positions.keys.include?(value)

    x, y = @positions[value]

    @rows[x][y] = nil
    @cols[y][x] = nil
  end

  def win?
    @cols.any? {|col| col.all?(&:nil?)} || @rows.any? {|row| row.all?(&:nil?)}
  end

  def sum
    @cols.flatten.compact.sum
  end

  def inspect
    @rows.map(&canal.map(&canal.to_s.rjust(4, ' ')).join).join("\n")
  end
end

boards = input.join.split("\n\n").map(&canal.split.map(&:to_i)).map do |values|
  Board.new(values)
end

part1 = %q{
winning_board = nil
draws.each do |value|
  boards.each do |board|
    board.draw(value)

    if board.win?
      winning_board = board
      puts value * winning_board.sum
      break
    end
  end

  break if winning_board
end
}

winning_boards = {}

draws.each do |value|
  boards.each do |board|
    next if winning_boards[board]

    board.draw(value)

    if board.win?
      winning_boards[board] = true

      if winning_boards.size == boards.size
        puts value * board.sum

        puts board.inspect
      end
    end
  end
end
