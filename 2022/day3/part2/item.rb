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
