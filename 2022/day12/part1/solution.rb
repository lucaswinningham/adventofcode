require 'set'

require 'solution_file'

require_relative './grid'
require_relative './priority_queue'
require_relative './manhattan_distance'

SolutionFile.with __dir__, benchmarks: true do |input|
  grid = Grid.parse input

  grid.for_all do |square|
    square.h_score = ManhattanDistance.call(square, grid.goal)
  end

  queue = PriorityQueue.new(&:f_score)

  grid.start.g_score = 0
  queue.enqueue grid.start

  closed = Set.new

  while queue.any?
    square = queue.dequeue

    break if square == grid.goal

    closed.add square

    successors = [
      grid.at(row: square.row + 1, col: square.col), # N
      grid.at(row: square.row, col: square.col + 1), # E
      grid.at(row: square.row - 1, col: square.col), # S
      grid.at(row: square.row, col: square.col - 1)  # W
    ].compact

    successors.filter! do |successor|
      successor.elevation <= square.elevation + 1
    end

    successors.each do |successor|
      next if closed.include? successor

      tentative_g_score = square.g_score + 1

      next if queue.include?(successor) && tentative_g_score >= successor.g_score

      successor.predecessor = square
      successor.g_score = tentative_g_score

      if queue.include?(successor)
        queue.reprioritize
      else
        queue.enqueue(successor)
      end
    end
  end

  steps = 0
  square = grid.goal
  while square
    square = square.predecessor
    steps += 1 if square
  end

  steps
end
