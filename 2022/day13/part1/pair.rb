require 'json'

class Pair
  def initialize(input)
    @left, @right = input.split("\n")
  end

  def correct?
    return @correct unless @correct.nil?

    @correct = compare(JSON.parse(@left), JSON.parse(@right))
  end

  private

  def compare(left, right, level = 0)
    puts "#{'  ' * level} - Compare #{left.inspect} vs #{right.inspect}"
    level += 1

    left_value = left.shift
    right_value = right.shift

    if left_value.nil? && right_value.nil?
      return
    elsif left_value.nil?
      puts "#{'  ' * level} - Left side ran out of items, so inputs are in the right order"
      return true
    elsif right_value.nil?
      puts "#{'  ' * level} - Right side ran out of items, so inputs are not in the right order"
      return false
    end

    if left_value.is_a?(Array) && right_value.is_a?(Array)
      result = compare(left_value, right_value, level)

      if result.nil?
        return compare(left, right, level)
      else
        return result
      end
    elsif !left_value.is_a?(Array) && !right_value.is_a?(Array)
      if left_value < right_value
        puts "#{'  ' * (level + 1)} - Left side is smaller, so inputs are in the right order"
        return true
      elsif right_value < left_value
        puts "#{'  ' * (level + 1)} - Right side is smaller, so inputs are not in the right order"
        return false
      else
        return compare(left, right, level)
      end
    else
      return compare(Array(left_value), Array(right_value), level)
    end
  end
end
