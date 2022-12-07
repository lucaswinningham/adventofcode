module DayFile
  class << self
    def with(dir, &block)
      input_filepath = File.join(dir, 'input.txt')
      output_filepath = File.join(dir, 'output.txt')

      input_file = File.read input_filepath

      result = block&.call input_file

      puts result
      File.write(output_filepath, "#{result}\n")
    end
  end
end
