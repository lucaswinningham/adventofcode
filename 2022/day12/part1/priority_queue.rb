class PriorityQueue
  def initialize(&block)
    @how = block
    @array = []
  end

  def dequeue
    @array.shift
  end

  def enqueue(*items)
    @array = [*@array, *items]
    reprioritize
  end

  def any?
    @array.any?
  end

  def reprioritize
    @array = @array.sort_by { |item| @how.call item }
  end

  def include?(item)
    @array.include? item
  end
end
