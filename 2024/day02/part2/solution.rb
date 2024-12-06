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

  Entry = Struct.new(:record) do
    def safe?
      return @safe if defined?(@safe)

      @safe = record.safe? || variants.any?(&:safe?)
    end

    private

    def variants
      @variants ||= record.levels.combination(record.levels.length - 1).map do |variant_levels|
        Record.new(variant_levels)
      end
    end
  end

  class << self
    def call(input)
      records = Parse.call(input).map { |levels| Record.new(levels) }

      entries = records.map { |record| Entry.new(record) }

      entries.count(&:safe?)
    end
  end
end
