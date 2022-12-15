require_relative './position'

class Rope
  class Knot
    attr_accessor :position
    attr_reader :tether

    def initialize(options = {})
      @position = Position.new
      @tether = options.fetch(:tether, nil)
    end

    def snap
      return unless move?

      @position = Position.new(x: position.x + x_offset, y: position.y + y_offset)
    end

    private

    def move?
      1 < (tether.position.x - position.x).abs || 1 < (tether.position.y - position.y).abs
    end

    def x_offset
      (tether.position.x - position.x).clamp(-1, 1)
    end

    def y_offset
      (tether.position.y - position.y).clamp(-1, 1)
    end
  end
end
