require_relative '../parse'

module Solution
  class << self
    def call(input)
      list1, list2 = Parse.call(input).map(&:sort)

      list1.zip(list2).sum { |entry1, entry2| (entry1 - entry2).abs }
    end
  end
end
