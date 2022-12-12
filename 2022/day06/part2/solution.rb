require 'solution_file'

SolutionFile.with __dir__ do |input|
  window = 14

  input.chars.each_cons(window).with_index do |cons, index|
    break index + window if cons.uniq == cons
  end
end
