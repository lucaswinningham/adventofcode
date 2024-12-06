require_relative '../parse'

module Solution
  Record = Struct.new(:levels) do
    def safe?
      return @safe if defined?(@safe)

      @safe ||= determine_safety
    end

    private

    def determine_safety
      levels.each_cons(2) do |level1, level2|
        return false if level1 == level2

        difference = (level1 - level2).abs
        return false if difference < 1 || difference > 3

        return false if increasing? && level2 < level1

        return false if !increasing? && level1 < level2
      end

      true
    end

    def increasing?
      @increasing ||= levels.first < levels.last
    end
  end

  class << self
    def call(input)
      records = Parse.call(input).map { |levels| Record.new(levels) }

      records.count(&:safe?)
    end
  end
end
