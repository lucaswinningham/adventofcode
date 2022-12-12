require_relative './item'

class Group
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def badge
    Item.new input.map(&:chars).reduce(&:&).first
  end
end
