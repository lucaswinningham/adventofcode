class Operator
  def initialize(options = {})
    @left = options.fetch(:left)
    @right = options.fetch(:right)
  end

  def call(value)
    raise NotImplementedError
  end

  private

  attr_reader :left, :right

  def left_callable
    @left_callable = if left == 'old'
                       @left_callable = proc { |value| value }
                     else
                       @left_callable = proc { left.to_i }
                     end
  end

  def right_callable
    @right_callable = if right == 'old'
                        @right_callable = proc { |value| value }
                      else
                        @right_callable = proc { right.to_i }
                      end
  end

  class Add < Operator
    def call(value)
      left_callable.call(value) + right_callable.call(value)
    end
  end

  class Multiply < Operator
    def call(value)
      left_callable.call(value) * right_callable.call(value)
    end
  end
end
