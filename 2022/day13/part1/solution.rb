require 'set'

require 'solution_file'

require_relative './pair'

SolutionFile.with __dir__ do |input|
  pairs = input.split("\n\n").map { |pair_input| Pair.new pair_input }

  pairs.each_with_index.reduce(0) do |acc, (pair, index)|
    pair.correct? ? acc + index + 1 : acc
  end

  # 6050 is too high
  # 5795 is too low
end
