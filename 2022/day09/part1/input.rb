module Input
  DIRECTION_MAP = {
    'U' => :up,
    'R' => :right,
    'D' => :down,
    'L' => :left
  }

  class << self
    def to_stream(input)
      input.split("\n").reduce([]) do |stream, line|
        direction, count = line.split(' ')

        [*stream, *Array.new(count.to_i, DIRECTION_MAP[direction])]
      end
    end
  end
end
