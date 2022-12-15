require_relative './position'

class Rope
  class Knot
    attr_accessor :position

    def initialize
      @position = Position.new
    end
  end
end
