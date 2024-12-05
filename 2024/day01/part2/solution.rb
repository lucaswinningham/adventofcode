require_relative '../parse'

module Solution
  class << self
    def call(input)
      tallies1, tallies2 = Parse.call(input).map(&:tally)

      tallies1.sum { |key, tally| key * tally * tallies2.fetch(key, 0) }
    end
  end
end
