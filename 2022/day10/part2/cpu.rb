require_relative 'cpu/counter'
require_relative 'cpu/instruction'

module CPU
  class << self
    attr_accessor :instructions

    def tick(&block)
      cycle.increment

      
      instruction.execute
      block&.call

      instruction.access_memory register
      instruction.write_back self
    end

    def register
      @register ||= Counter.new value: 1
    end

    def cycle
      @cycle ||= Counter.new
    end

    def instruction
      @instruction ||= index
    end

    def index
      @instruction = decode(fetch)
    end

    def running?
      !instruction.nil?
    end

    private

    def fetch
      instructions.shift
    end

    def decode(instr)
      return unless !instr.nil?

      name, parameter = instr.split(' ')

      Instruction.parse(name: name.to_sym, parameter: parameter&.to_i)
    end
  end
end
