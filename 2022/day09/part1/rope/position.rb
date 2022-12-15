class Rope
  class Position
    attr_accessor :x, :y

    def initialize(options = {})
      @x = options.fetch(:x, 0)
      @y = options.fetch(:y, 0)
    end

    def set(x:, y:)
      self.x = x
      self.y = y
    end

    def to_s
      "#{x},#{y}"
    end

    class << self
      def dup(position)
        new(x: position.x, y: position.y)
      end

      def parse(position_string)
        x, y = position_string.split(',')

        new(x: x, y: y)
      end
    end
  end
end
