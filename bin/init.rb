#!/usr/bin/env ruby

require 'date'
require 'fileutils'
require 'optparse'

require_relative 'utils/constants'

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: `ruby bin/init.rb [options]`'

  opts.on('-r ROOT', '--root=ROOT', 'Root directory, defaults to current directory') do |v|
    options[:root] = File.expand_path v
  end

  opts.on('-y YEAR', '--year=YEAR', 'Year of challenge, defaults to current year', Numeric) do |v|
    options[:year] = v
  end

  opts.on('-d DAY', '--day=DAY', 'Day of challenge, required', Numeric) do |v|
    options[:day] = v
  end

  opts.on('-h', '--help', 'Prints this help') { puts(opts).tap { exit } }
end

option_parser.parse!

root = options.fetch(:root) { File.expand_path('..', __dir__) }
year = options.fetch(:year) { Date.today.year }
day = options.fetch(:day) { puts(option_parser.help).tap { exit 1 } }

EEXISTS = File::WRONLY|File::CREAT|File::EXCL

year_directory = "#{root}/#{year}"
day_directory = "#{year_directory}/day#{day.to_s.rjust(2, '0')}"
example_input_filename = "#{day_directory}/#{Constants.example_input_filename}"
thoughts_filename = "#{day_directory}/#{Constants.thoughts_filename}"
parse_filename = "#{day_directory}/#{Constants.parse_filename}"

puts "creating directory: #{day_directory}"
FileUtils.mkdir_p(day_directory)

puts "touching file: #{example_input_filename}"
FileUtils.touch(example_input_filename)

puts "writing file: #{thoughts_filename}"
File.write(thoughts_filename, Constants.thoughts_file(day: day), mode: EEXISTS)

puts "writing file: #{parse_filename}"
File.write(parse_filename, Constants.parse_file, mode: EEXISTS)

[1, 2].each do |part|
  part_directory = "#{day_directory}/part#{part}"
  input_filename = "#{part_directory}/#{Constants.input_filename}"
  problem_filename = "#{part_directory}/#{Constants.problem_filename}"
  solution_filename = "#{part_directory}/#{Constants.solution_filename}"

  puts "creating directory: #{part_directory}"
  FileUtils.mkdir_p(part_directory)

  puts "touching file: #{input_filename}"
  FileUtils.touch(input_filename)

  puts "touching file: #{problem_filename}"
  FileUtils.touch(problem_filename)

  puts "writing file: #{solution_filename}"
  File.write(solution_filename, Constants.solution_file, mode: EEXISTS)
end
