require_relative '../parse'

module Solution
  class << self
    def call(input)
      parsed_input = Parse.call(input)
    end
  end
end
