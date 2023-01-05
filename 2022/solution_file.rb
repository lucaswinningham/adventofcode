require 'benchmark'

module SolutionFile
  class << self
    def with(dir, options = {}, &block)
      input_filepath = File.join(dir, '../input.txt')
      output_filepath = File.join(dir, 'output.txt')

      input_file = File.read input_filepath

      result = with_result(options.merge(input_file: input_file), &block)

      puts result
      File.write(output_filepath, "#{result}\n")
    end

    private

    def with_result(options = {}, &block)
      input_file = options.fetch(:input_file)

      if options.fetch(:benchmarks, false)
        result = nil

        Benchmark.bm do |x|
          x.report { result = block&.call input_file }
        end

        return result
      end

      block&.call input_file
    end
  end
end
