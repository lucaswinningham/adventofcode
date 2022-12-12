require 'solution_file'

require_relative './visualization'
require_relative './instructions'

SolutionFile.with __dir__ do |input|
  visualization_input, instructions_input = input.split "\n\n"

  visualization = Visualization.new visualization_input
  instructions = Instructions.new instructions_input

  instructions.each { |instruction| visualization.execute instruction }

  visualization.top
end
