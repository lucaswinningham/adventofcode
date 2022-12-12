require 'solution_file'

SolutionFile.with __dir__ do |input|
  input.chars.each_cons(4).with_index do |cons, index|
    break index + 4 if cons.uniq == cons
  end
end
