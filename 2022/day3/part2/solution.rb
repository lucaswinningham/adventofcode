require 'solution_file'

require_relative './group'

SolutionFile.with __dir__ do |input|
  rucksack_lines = input.split "\n"

  groups = rucksack_lines.each_slice(3).map { |group| Group.new group }

  groups.map(&:badge).sum(&:priority)
end
