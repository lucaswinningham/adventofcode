require 'fileutils'

pwd, year, day = ARGV

pwd = File.expand_path pwd
year = year.to_s
day = day.to_s

THOUGHTS_FILE= <<~THOUGHTS
# Day #{day}

## Part 1

## Part 2
THOUGHTS

INPUT_FILE = <<~INPUT
module Input
  class << self
    def parse(input)
      
    end
  end
end
INPUT

SOLUTION_FILE = <<~SOLUTION
SOLUTION

year_directory = "#{pwd}/#{year}"
day_directory = "#{year_directory}/day#{day.to_s.rjust(2, '0')}"

FileUtils.mkdir_p day_directory
FileUtils.touch "#{day_directory}/example_input.txt"
FileUtils.touch "#{day_directory}/input.txt"
File.write("#{day_directory}/thoughts.md", THOUGHTS_FILE)
File.write("#{day_directory}/input.rb", INPUT_FILE)

[1, 2].each do |part|
  part_directory = "#{day_directory}/part#{part}"
  FileUtils.mkdir_p part_directory

  FileUtils.touch "#{part_directory}/problem.txt"
  File.write("#{part_directory}/solution.rb", SOLUTION_FILE)
end

# # Testing cleanup

[1, 2].each do |part|
  part_directory = "#{day_directory}/part#{part}"

  FileUtils.rm "#{part_directory}/problem.txt"
  FileUtils.rm "#{part_directory}/solution.rb"
  FileUtils.rmdir part_directory
end

FileUtils.rm "#{day_directory}/example_input.txt"
FileUtils.rm "#{day_directory}/input.txt"
FileUtils.rm "#{day_directory}/thoughts.md"
FileUtils.rm "#{day_directory}/input.rb"
FileUtils.rmdir day_directory
FileUtils.rmdir year_directory
