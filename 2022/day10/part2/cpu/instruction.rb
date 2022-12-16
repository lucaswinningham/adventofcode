require_relative 'instruction/addx'
require_relative 'instruction/noop'

module CPU
  class Instruction
    def initialize(options = {}); end

    def execute; end

    def access_memory(register); end

    def write_back(cpu); end

    class << self
      def parse(options = {})
        const_get(options.fetch(:name).capitalize).new options
      end
    end
  end
end
