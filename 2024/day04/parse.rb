module Parse
  class << self
    def call(input)
      input.split("\n").map { |line| line.split("") }
    end
  end
end
