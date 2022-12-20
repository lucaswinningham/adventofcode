require 'set'

require 'solution_file'

require_relative './grid'

SolutionFile.with __dir__, benchmarks: true do |input|
  grid = Grid.parse input

  queue = [grid.start]

  visited = Set.new [grid.start.to_s]

  goal = while queue.any?
    square = queue.shift

    break square if square.elevation.zero?
    visited.add square.to_s

    predecessors = [
      grid.at(row: square.row + 1, col: square.col), # N
      grid.at(row: square.row, col: square.col + 1), # E
      grid.at(row: square.row - 1, col: square.col), # S
      grid.at(row: square.row, col: square.col - 1)  # W
    ].compact

    predecessors.filter! do |predecessor|
      square.elevation - 1 <= predecessor.elevation && !visited.include?(predecessor.to_s)
    end

    predecessors.each do |predecessor|
      predecessor.successor = square
      queue.push predecessor
      visited.add predecessor.to_s
    end
  end

  steps = 0
  square = goal
  while square
    square = square.successor
    steps += 1 if square
  end

  steps
end
