require 'solution_file'

require_relative './pair'

SolutionFile.with __dir__ do |input|
  pairs = input.split("\n").map { |line| Pair.new line }

  pairs.count(&:needs_attention?)
end
