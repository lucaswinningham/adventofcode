module Constants
  class << self
    def example_input_filename
      @example_input_filename ||= 'example_input.txt'
    end

    def input_filename
      @input_filename ||= 'input.txt'
    end

    def example_output_filename
      @output_filename ||= 'example_output.txt'
    end

    def output_filename
      @output_filename ||= 'output.txt'
    end

    def thoughts_filename
      @thoughts_filename ||= 'thoughts.md'
    end

    def parse_filename
      @parse_filename ||= 'parse.rb'
    end

    def problem_filename
      @problem_filename ||= 'problem.md'
    end

    def solution_filename
      @solution_filename ||= 'solution.rb'
    end

    def thoughts_file(options = {})
      day = options.fetch(:day)

      <<~THOUGHTS
        # Day #{day}

        ## Part 1

        ## Part 2

      THOUGHTS
    end

    def parse_file
      @parse_file ||= <<~INPUT
        module Parse
          class << self
            def call(input)
              
            end
          end
        end
      INPUT
    end

    def solution_file
      @solution_file ||= <<~SOLUTION
        require_relative '../parse'

        module Solution
          class << self
            def call(input)
              parsed_input = Parse.call(input)
            end
          end
        end
      SOLUTION
    end
  end
end
