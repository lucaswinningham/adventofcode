module Input
  class << self
    def to_stream(input)
      input.split("\n").reduce([]) do |stream, line|
        name, parameter = line.split(' ')

        [*stream, { name: name.to_sym, parameter: parameter&.to_i }]
      end
    end
  end
end
