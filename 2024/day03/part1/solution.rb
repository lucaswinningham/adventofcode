require_relative '../parse'

module Solution
  MulInstruction = Struct.new(:multiplier, :multiplicand) do
    def product
      return @product if defined?(@product)

      @product = multiplier.to_i * multiplicand.to_i
    end
  end

  class << self
    def call(input)
      parsed_input = Parse.call(input)

      mul_instructions = parsed_input.scan(/mul\(\d{1,3},\d{1,3}\)/).map do |mul_instruction|
        matches = mul_instruction.match(/mul\((?<multiplier>\d{1,3}),(?<multiplicand>\d{1,3})\)/)

        MulInstruction.new(matches[:multiplier], matches[:multiplicand])
      end

      mul_instructions.sum(&:product)
    end
  end
end
