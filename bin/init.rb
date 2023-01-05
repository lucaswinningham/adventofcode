#!/usr/bin/env ruby

require 'date'
require 'fileutils'
require 'optparse'

require_relative './constants'

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: `ruby bin/init.rb [options]`'

  opts.on('-r ROOT', '--root=ROOT', 'Root directory, defaults to current directory') do |v|
    options[:root] = File.expand_path v
  end

  opts.on('-y YEAR', '--year=YEAR', 'Year of challenge, defaults to current year', Numeric) do |v|
    options[:year] = v
  end

  opts.on('-d DAY', '--day=DAY', 'Day of challenge, defaults to current day', Numeric) do |v|
    options[:day] = v
  end

  opts.on('-h', '--help', 'Prints this help') { puts(opts).tap { exit } }
end

option_parser.parse!

root = options.fetch(:root) { File.expand_path('..', __dir__) }
year = options.fetch(:year) { Date.today.year }
day = options.fetch(:day) { Date.today.year }

year_directory = "#{root}/#{year}"
day_directory = "#{year_directory}/day#{day.to_s.rjust(2, '0')}"

EEXISTS = File::WRONLY|File::CREAT|File::EXCL

FileUtils.mkdir_p day_directory
FileUtils.touch "#{day_directory}/#{Constants.example_input_filename}"
FileUtils.touch "#{day_directory}/#{Constants.input_filename}"
File.write("#{day_directory}/#{Constants.thoughts_filename}", Constants.thoughts_file(day: day), mode: EEXISTS)
File.write("#{day_directory}/#{Constants.parser_filename}", Constants.parser_file, mode: EEXISTS)

[1, 2].each do |part|
  part_directory = "#{day_directory}/part#{part}"
  FileUtils.mkdir_p part_directory

  FileUtils.touch "#{part_directory}/problem.txt"
  File.write("#{part_directory}/solution.rb", Constants.solution_file, mode: EEXISTS)
end

# # Testing cleanup

# [1, 2].each do |part|
#   part_directory = "#{day_directory}/part#{part}"

#   FileUtils.rm "#{part_directory}/problem.txt"
#   FileUtils.rm "#{part_directory}/solution.rb"
#   FileUtils.rmdir part_directory
# end

# FileUtils.rm "#{day_directory}/#{Constants.example_input_filename}"
# FileUtils.rm "#{day_directory}/#{Constants.input_filename}"
# FileUtils.rm "#{day_directory}/#{Constants.thoughts_filename}"
# FileUtils.rm "#{day_directory}/#{Constants.parser_filename}"
# FileUtils.rmdir day_directory
# FileUtils.rmdir year_directory
