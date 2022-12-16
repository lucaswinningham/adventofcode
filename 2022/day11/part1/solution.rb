require 'solution_file'

require_relative './monkey'

SolutionFile.with __dir__ do |input|
  monkeys = input.split("\n\n").map { |monkey| Monkey.parse monkey }

  20.times.each do
    monkeys.each do |monkey|
      while (item = monkey.items.shift)
        new_item = monkey.operation.call(item) / 3
        monkey.items_inspected += 1

        if (new_item % monkey.modulus).zero?
          monkeys[monkey.on_true].items.push new_item
        else
          monkeys[monkey.on_false].items.push new_item
        end
      end
    end
  end

  monkeys.map(&:items_inspected).sort.reverse.take(2).reduce(&:*)
end
