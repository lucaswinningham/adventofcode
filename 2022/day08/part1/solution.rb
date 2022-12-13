require 'solution_file'

require_relative './tree'

SolutionFile.with __dir__ do |input|
  lines = input.split("\n")
  width = lines.first.chars.count
  height = lines.count
  grid = Array.new(width) { Array.new(height) { Tree.new } }

  lines.each.with_index do |line, row|
    line.chars.each.with_index do |height, col|
      grid[row][col].height = height.to_i
    end
  end

  grid.each_with_index do |row, row_index|
    row.each_with_index do |tree, col_index|
      to_the_east = row.slice(col_index + 1, width - (col_index + 1))
      to_the_west = row.slice(0, col_index)

      to_the_east.reject(&:west).each do |other_tree|
        other_tree.west = true if other_tree.height <= tree.height
      end

      to_the_west.reject(&:east).each do |other_tree|
        other_tree.east = true if other_tree.height <= tree.height
      end
    end
  end

  grid.transpose.each_with_index do |col, col_index|
    col.each_with_index do |tree, row_index|
      to_the_south = col.slice(row_index + 1, height - (row_index + 1))
      to_the_north = col.slice(0, row_index)

      to_the_south.reject(&:north).each do |other_tree|
        other_tree.north = true if other_tree.height <= tree.height
      end

      to_the_north.reject(&:south).each do |other_tree|
        other_tree.south = true if other_tree.height <= tree.height
      end
    end
  end

  grid.sum { |row| row.count(&:visible?) }
end
