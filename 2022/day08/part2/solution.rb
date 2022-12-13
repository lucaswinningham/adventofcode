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

  grid.each do |row|
    row.each_with_index do |tree, col_index|
      if (east_index = col_index + 1) < width
        eastern_trees = 0

        while east_index < width - 1 && row[east_index].height < tree.height
          east_index += 1
          eastern_trees += 1
        end

        tree.east = eastern_trees + 1
      else
        tree.east = 0
      end

      if (west_index = col_index - 1) >= 0
        western_trees = 0

        while west_index > 0 && row[west_index].height < tree.height
          west_index -= 1
          western_trees += 1
        end

        tree.west = western_trees + 1
      else
        tree.west = 0
      end
    end
  end

  grid.transpose.each do |col|
    col.each_with_index do |tree, row_index|
      if (south_index = row_index + 1) < height
        southern_trees = 0

        while south_index < height - 1 && col[south_index].height < tree.height
          south_index += 1
          southern_trees += 1
        end

        tree.south = southern_trees + 1
      else
        tree.south = 0
      end

      if (north_index = row_index - 1) >= 0
        northern_trees = 0

        while north_index > 0 && col[north_index].height < tree.height
          north_index -= 1
          northern_trees += 1
        end

        tree.north = northern_trees + 1
      else
        tree.north = 0
      end
    end
  end

  grid.map { |row| row.map(&:score).max }.max
end
