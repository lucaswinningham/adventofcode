require_relative '../parse'

module Solution
  TARGET_WORD = "XMAS"

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

      indexes["X"].each do |entry|
        directions = []

        directions.push(:N) if entry.point.y + 1 >= TARGET_WORD.length
        directions.push(:S) if (height - entry.point.y) >= TARGET_WORD.length

        directions.push(:W) if entry.point.x + 1 >= TARGET_WORD.length
        directions.push(:E) if (width - entry.point.x) >= TARGET_WORD.length

        directions.push(:NE) if directions.include?(:N) && directions.include?(:E)
        directions.push(:SE) if directions.include?(:S) && directions.include?(:E)
        directions.push(:SW) if directions.include?(:S) && directions.include?(:W)
        directions.push(:NW) if directions.include?(:N) && directions.include?(:W)

        directions.each do |direction|
          case direction
          when :N
            if grid[entry.point.x][entry.point.y - 1].letter == "M"
              if grid[entry.point.x][entry.point.y - 2].letter == "A"
                if grid[entry.point.x][entry.point.y - 3].letter == "S"
                  count += 1
                end
              end
            end
          when :NE
            if grid[entry.point.x + 1][entry.point.y - 1].letter == "M"
              if grid[entry.point.x + 2][entry.point.y - 2].letter == "A"
                if grid[entry.point.x + 3][entry.point.y - 3].letter == "S"
                  count += 1
                end
              end
            end
          when :E
            if grid[entry.point.x + 1][entry.point.y].letter == "M"
              if grid[entry.point.x + 2][entry.point.y].letter == "A"
                if grid[entry.point.x + 3][entry.point.y].letter == "S"
                  count += 1
                end
              end
            end
          when :SE
            if grid[entry.point.x + 1][entry.point.y + 1].letter == "M"
              if grid[entry.point.x + 2][entry.point.y + 2].letter == "A"
                if grid[entry.point.x + 3][entry.point.y + 3].letter == "S"
                  count += 1
                end
              end
            end
          when :S
            if grid[entry.point.x][entry.point.y + 1].letter == "M"
              if grid[entry.point.x][entry.point.y + 2].letter == "A"
                if grid[entry.point.x][entry.point.y + 3].letter == "S"
                  count += 1
                end
              end
            end
          when :SW
            if grid[entry.point.x - 1][entry.point.y + 1].letter == "M"
              if grid[entry.point.x - 2][entry.point.y + 2].letter == "A"
                if grid[entry.point.x - 3][entry.point.y + 3].letter == "S"
                  count += 1
                end
              end
            end
          when :W
            if grid[entry.point.x - 1][entry.point.y].letter == "M"
              if grid[entry.point.x - 2][entry.point.y].letter == "A"
                if grid[entry.point.x - 3][entry.point.y].letter == "S"
                  count += 1
                end
              end
            end
          when :NW
            if grid[entry.point.x - 1][entry.point.y - 1].letter == "M"
              if grid[entry.point.x - 2][entry.point.y - 2].letter == "A"
                if grid[entry.point.x - 3][entry.point.y - 3].letter == "S"
                  count += 1
                end
              end
            end
          end
        end
      end

      count
    end
  end
end
