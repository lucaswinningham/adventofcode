require_relative './elf'

class Pair
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def needs_attention?
    first.cover?(second) || second.cover?(first)
  end

  def to_s
    "#{first.start}-#{first.stop},#{second.start}-#{second.stop}"
  end

  private

  def elves
    @elves ||= input.split(',').map do |range|
      range.split('-').then do |start, stop|
        Elf.new(start: start.to_i, stop: stop.to_i)
      end
    end
  end

  def first
    @first ||= elves[0]
  end

  def second
    @second ||= elves[1]
  end
end
