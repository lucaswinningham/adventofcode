require 'set'

require_relative 'rope/knot'
require_relative 'rope/position'

class Rope
  NUM_KNOTS = 10

  attr_reader :all_unique_tail_positions

  def initialize
    @all_unique_tail_positions ||= Set.new [tail.position.to_s]
  end

  def step(direction)
    next_head_position = Position.dup head.position

    case direction
    when :up then next_head_position.y += 1
    when :right then next_head_position.x += 1
    when :down then next_head_position.y -= 1
    when :left then next_head_position.x -= 1
    end

    head.position = next_head_position

    except_head.each(&:snap)

    all_unique_tail_positions.add tail.position.to_s
  end

  def knots
    @knots ||= (1..NUM_KNOTS).to_a.reduce([]) do |acc, _|
      [*acc, Knot.new(tether: acc.last)]
    end
  end

  def except_head
    @except_head ||= knots.slice(1, NUM_KNOTS - 1)
  end

  def head
    @head ||= knots.first
  end

  def tail
    @tail ||= knots.last
  end
end
