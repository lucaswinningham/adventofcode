require_relative 'visualization/stack'

class Visualization
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def stacks
    @stacks ||= Hash.new { |h, k| h[k] = [] }.tap do |initial_stacks|
      graph.reverse.each do |tier|
        tier.chars.each_slice(4).with_index do |crate_visual, stack_number|
          match = crate_visual.join.match(/\[(?<letter>[A-Z])\]/)

          initial_stacks[stack_number + 1].push match.named_captures['letter'] if match
        end
      end
    end
  end

  def execute(instruction)
    from_stack = stacks[instruction.from]

    crates = from_stack.slice!(from_stack.length - instruction.quantity, instruction.quantity)

    stacks[instruction.to].concat crates.reverse
  end

  def top
    stacks.values.map(&:last).join
  end

  private

  def split_input
    @split_input ||= input.split("\n")
  end

  def graph
    @graph ||= split_input[0..-2]
  end

  def labels
    @labels ||= split_input.last
  end
end
