module CPU
  class Instruction
    class Noop < Instruction
      def write_back(cpu)
        cpu.index
      end
    end
  end
end
