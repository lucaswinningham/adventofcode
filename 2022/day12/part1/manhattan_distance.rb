module ManhattanDistance
  class << self
    def call(square1, square2)
      (square1.row - square2.row).abs +
        (square1.col - square2.col).abs +
        (square1.elevation - square2.elevation).abs
    end
  end
end
