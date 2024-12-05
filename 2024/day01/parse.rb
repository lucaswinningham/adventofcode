module Parse
  class << self
    def call(input)
      input.split("\n").map { |line| line.split(" ").map(&:to_i) }.transpose
    end
  end
end
