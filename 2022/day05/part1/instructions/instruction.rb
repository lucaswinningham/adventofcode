class Instructions
  class Instruction
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def quantity
      @quantity ||= match['quantity'].to_i
    end

    def from
      @from ||= match['from'].to_i
    end

    def to
      @to ||= match['to'].to_i
    end

    private

    def match
      # move 1 from 1 to 2
      @match ||= input.match(/move (?<quantity>\d+) from (?<from>\d+) to (?<to>\d+)/).named_captures
    end
  end
end
