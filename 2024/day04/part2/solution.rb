require_relative '../parse'

module Solution
  Point = Struct.new(:x, :y) do
    def to_s
      "(#{x},#{y})"
    end
  end

  Entry = Struct.new(:letter, :point, keyword_init: true) do
    def to_s
      "#{letter}@#{point}"
    end
  end

  class << self
    def call(input)
      parsed_input = Parse.call(input)

      width = parsed_input.first.length
      height = parsed_input.length

      indexes = Hash.new { |h, k| h[k] = [] }

      grid = parsed_input.map.with_index do |row, row_index|
        row.map.with_index do |letter, col_index|
          Entry.new(letter:, point: Point.new(row_index, col_index)).tap do |entry|
            indexes[letter].push(entry)
          end
        end
      end

      count = 0

      indexes["A"].each do |entry|
        # Ignore the outside ring of the grid
        next if entry.point.x.zero?
        next if entry.point.y.zero?
        next if entry.point.x + 1 == width
        next if entry.point.y + 1 == height

        diagonal_neighbors = [
          grid[entry.point.x + 1][entry.point.y - 1], # NE
          grid[entry.point.x + 1][entry.point.y + 1], # SE
          grid[entry.point.x - 1][entry.point.y + 1], # SW
          grid[entry.point.x - 1][entry.point.y - 1], # NW
        ]

        m_neighbors = diagonal_neighbors.filter { |entry| entry.letter == "M" }
        next if m_neighbors.count != 2

        next if diagonal_neighbors.count { |entry| entry.letter == "S" } != 2

        m_neighbor1, m_neighbor2 = m_neighbors

        if m_neighbor1.point.x == m_neighbor2.point.x || m_neighbor1.point.y == m_neighbor2.point.y
          count += 1
        end
      end

      count
    end
  end
end
