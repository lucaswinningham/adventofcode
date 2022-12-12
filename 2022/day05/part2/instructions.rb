require_relative 'instructions/instruction'

class Instructions
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def each(&block)
    instructions.each(&block)
  end

  private

  def instructions
    @instructions ||= input.split("\n").map { |instr_input| Instruction.new instr_input }
  end
end
