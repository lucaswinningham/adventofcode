require 'solution_file'

require_relative './numbers'

SolutionFile.with __dir__ do |input|
  numbers = Numbers.parse input

  numbers.og_array.each do |element|
    numbers.evaluate_element element.og_index
  end

  zero = numbers.find { |element| element.number.zero? }

  [1000, 2000, 3000].map { |offset|
    numbers.at(zero.index + offset).number
  }.sum

  # -2928 not right
end
