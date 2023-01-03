class Numbers
  Element = Struct.new(:number, :og_index, :index, :truncated, keyword_init: true) do
    def og_index=(_); end
  end

  attr_reader :input, :array, :og_array

  def initialize(input)
    @input = input
    @array = initial_array
    @og_array = array.dup
  end

  def evaluate_element(og_index)
    find { |e| e.og_index == og_index }.tap do |element|
      next_index = element.index + element.truncated
      next_index += input.length if next_index.negative?
      next_index -= input.length if input.length < next_index

      # puts "next_index: #{next_index}, element: #{element}" if next_index > 

      array.insert(next_index, array.delete_at(element.index))

      element.index = next_index

      # puts "element.index: #{element.index}, element.og_index: #{element.og_index}"
    end
  end

  def find(&block)
    array.find(&block)
  end

  def at(index)
    array[index % input.length]
  end

  private

  def initial_array
    input.each_with_index.reduce([]) do |accumulation, (number, index)|
      truncated = begin
        if number.negative?
          (number.abs % input.length) * -1
        else
          number % input.length
        end
      end

      accumulation.push Element.new(
        og_index: index,
        index: index,
        number: number,
        truncated: truncated
      )
    end
  end

  class << self
    def parse(input)
      new input.split("\n").map(&:to_i)
    end
  end
end
