require 'solution_file'

SolutionFile.with __dir__ do |input|
  elf_lines = input.split "\n\n"
  elves = elf_lines.map { |elf_line| elf_line.split("\n").map(&:to_i) }

  three_fattest_elf_total_snack_calories = elves.map(&:sum).max(3)

  elves.map(&:sum).max(3).sum
end
