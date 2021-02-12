# frozen_string_literal: true

input = File.readlines('11-1').map(&:strip)

# input[row][col]

def transform(cells)
  height = cells.size
  width = cells.first.size
  new_cells = cells.map(&:dup)

  (0...height).each do |row|
    (0...width).each do |col|
      count = 0

      [[-1, 1], [0, 1], [1, 1],
       [-1,0], [1, 0],
       [-1,-1],[0,-1],[1,-1]].each do |(drow, dcol)|
        if cells[row+drow]&.send(:[], col+dcol) == '#'
          count += 1
        end
      end

      if cells[row][col] == 'L' && count == 0
        new_cells[row][col] = '#'
      end

      if cells[row][col] == '#' && count >= 4
        puts [row,col].inspect
        new_cells[row][col] = 'L'
      end

    end
  end

  new_cells
end

def show(cells)
  puts cells.join("\n")
  puts
end

cells = input

show(cells)

show(transform(cells))

show(transform(transform(cells)))
