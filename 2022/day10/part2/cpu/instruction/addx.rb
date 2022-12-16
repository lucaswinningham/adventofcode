module CPU
  class Instruction
    class Addx < Instruction
      attr_reader :parameter

      def initialize(options = {})
        @parameter = options.fetch(:parameter)
      end

      def execute
        counter.increment
      end

      def access_memory(register)
        register.increment by: parameter if done?
      end

      def write_back(cpu)
        cpu.index if done?
      end

      private

      def counter
        @counter ||= Counter.new
      end

      def done?
        @done ||= counter.value == 2
      end
    end
  end
end
