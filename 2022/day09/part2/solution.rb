require 'solution_file'

require_relative './input'
require_relative './rope'

SolutionFile.with __dir__ do |input|
  stream = Input.to_stream input
  rope = Rope.new

  stream.each { |direction| rope.step direction }

  rope.all_unique_tail_positions.count
end
