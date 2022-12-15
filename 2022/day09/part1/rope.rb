require 'set'

require_relative 'rope/knot'
require_relative 'rope/position'

class Rope
  def step(direction)
    last_head_position = Position.dup head.position
    next_head_position = Position.dup head.position

    case direction
    when :up then next_head_position.y += 1
    when :right then next_head_position.x += 1
    when :down then next_head_position.y -= 1
    when :left then next_head_position.x -= 1
    end

    head.position = next_head_position

    if tail_too_far_from_head?
      all_unique_tail_positions.add last_head_position.to_s
      tail.position = last_head_position
    end
  end

  def all_unique_tail_positions
    @all_unique_tail_positions ||= Set.new [tail.position.to_s]
  end

  private

  def head
    @head ||= Knot.new
  end

  def tail
    @rail ||= Knot.new
  end

  def tail_too_far_from_head?
    1 < (head.position.x - tail.position.x).abs || 1 < (head.position.y - tail.position.y).abs
  end
end
