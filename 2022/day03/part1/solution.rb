require 'solution_file'

class Item
  LOWER_START = 1
  LOWER_OFFSET = 'a'.ord - LOWER_START

  UPPER_START = 27
  UPPER_OFFSET = 'A'.ord - UPPER_START

  attr_reader :char

  def initialize(char)
    @char = char
  end

  def priority
    char.ord - (upper? ? UPPER_OFFSET : LOWER_OFFSET)
  end

  private

  def upper?
    !!/[[:upper:]]/.match(char)
  end
end

class Compartment
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def items
    @items = input.chars.map { |char| Item.new char }
  end
end

class Rucksack
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def compartments
    @compartments ||= split_input.map { |compartment| Compartment.new compartment }
  end

  private

  def split_input
    @split_input ||= input.chars.each_slice(input.length / 2).to_a.map(&:join)
  end
end

SolutionFile.with __dir__ do |input|
  rucksack_lines = input.split "\n"

  rucksacks = rucksack_lines.map { |rucksack_line| Rucksack.new rucksack_line }

  rucksacks.sum do |rucksack|
    first_compartment = rucksack.compartments[0]
    second_compartment = rucksack.compartments[1]

    second_compartment_priorities = second_compartment.items.map(&:priority)

    first_compartment.items.find { |item|
      second_compartment_priorities.include? item.priority
    }.priority
  end
end
