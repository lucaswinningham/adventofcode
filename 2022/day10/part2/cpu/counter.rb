module CPU
  class Counter
    attr_reader :value

    def initialize(options = {})
      @value = options.fetch(:value, 0)
    end

    def increment(options = {})
      by = options.fetch(:by, 1)

      @value += by
    end
  end
end
