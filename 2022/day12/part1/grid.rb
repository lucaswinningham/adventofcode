require_relative './square'

class Grid
  attr_reader :array, :start, :goal

  def initialize(options = {})
    @array = options.fetch(:array)
    @start = options.fetch(:start)
    @goal = options.fetch(:goal)
  end

  def for_all(&block)
    array.each do |row|
      row.each do |square|
        block&.call(square)
      end
    end
  end

  def at(options = {})
    row = options.fetch(:row)
    col = options.fetch(:col)

    return if row < 0 || row >= height || col < 0 || col >= width

    array[row][col]
  end

  def height
    @heigh ||= array.length
  end

  def width
    @width ||= array[0].length
  end

  class << self
    def parse(input)
      start, goal = nil, nil

      array = input.split("\n").map.with_index do |line, row|
        line.chars.map.with_index do |letter, col|
          case letter
          when 'S' then start = Square.new(elevation: elevation['a'], row: row, col: col)
          when 'E' then goal = Square.new(elevation: elevation['z'], row: row, col: col)
          else Square.new(elevation: elevation[letter], row: row, col: col)
          end
        end
      end

      new(array: array, start: start, goal: goal)
    end

    private

    def elevation
      @elevation ||= Hash.new { |h, k| h[k] = k.ord - elevation_offset }
    end

    def elevation_offset
      @elevation_offset ||= 'a'.ord
    end
  end
end
