module Constants
  class << self
    def example_input_filename
      @example_input_filename ||= 'example_input.txt'
    end

    def input_filename
      @input_filename ||= 'input.txt'
    end

    def output_filename
      @output_filename ||= 'output.txt'
    end

    def thoughts_filename
      @thoughts_filename ||= 'thoughts.md'
    end

    def parser_filename
      @parser_filename ||= 'parser.rb'
    end

    def thoughts_file(options = {})
      day = options.fetch(:day)

      <<~THOUGHTS
        # Day #{day}

        ## Part 1

        ## Part 2
      THOUGHTS
    end

    def parser_file
      @parser_file ||= <<~INPUT
        module Parser
          class << self
            def call(input)
              
            end
          end
        end
      INPUT
    end

    def solution_file
      @solution_file ||= <<~SOLUTION
      SOLUTION
    end
  end
end
