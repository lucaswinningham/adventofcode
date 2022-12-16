require_relative './operator'

class Monkey
  attr_reader :id, :items, :operation, :modulus, :on_true, :on_false
  attr_accessor :items_inspected

  def initialize(options = {})
    @id = options.fetch(:id)
    @items = options.fetch(:items)
    @operation = options.fetch(:operation)
    @modulus = options.fetch(:modulus)
    @on_true = options.fetch(:on_true)
    @on_false = options.fetch(:on_false)

    @items_inspected = 0
  end

  class << self
    def parse(input)
      lines = input.split("\n")

      id = lines[0].match(/Monkey (?<id>\d+):/).named_captures['id'].to_i
      items = lines[1].gsub('  Starting items: ', '').split(', ').map(&:to_i)
      
      left, operator, right = lines[2].gsub('  Operation: new = ', '').split
      op = operator_map.fetch(operator).new(left: left, right: right)

      mod = lines[3].gsub('  Test: divisible by ', '').to_i

      on_true = lines[4].gsub('    If true: throw to monkey ', '').to_i
      on_false = lines[5].gsub('    If false: throw to monkey ', '').to_i

      new(id: id, items: items, operation: op, modulus: mod, on_true: on_true, on_false: on_false)
    end

    def operator_map
      @operator_map ||= {
        '+' => Operator::Add,
        '*' => Operator::Multiply
      }
    end
  end
end
