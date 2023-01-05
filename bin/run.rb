#!/usr/bin/env ruby

require 'date'
require 'benchmark'
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

  opts.on('-p PART', '--part=PART', 'Part of challenge, required', Numeric) do |v|
    options[:part] = v
  end

  opts.on('-b', '--[no-]benchmarks', 'Report benchmarks, defaults to true') do |v|
    options[:benchmarks] = v
  end

  opts.on('-h', '--help', 'Prints this help') { puts(opts).tap { exit } }
end

option_parser.parse!

root = options.fetch(:root) { File.expand_path('..', __dir__) }
year = options.fetch(:year) { Date.today.year }
day = options.fetch(:day) { Date.today.year }
part = options.fetch(:part) { puts(option_parser.help).tap { exit 1 } }
benchmarks = options.fetch(:benchmarks, true)

year_directory = "#{root}/#{year}"
day_directory = "#{year_directory}/day#{day.to_s.rjust(2, '0')}"
part_directory = "#{day_directory}/part#{part}"

input_filepath = "#{day_directory}/#{Constants.input_filename}"
output_filepath = "#{part_directory}/#{Constants.output_filename}"

input_file = File.read input_filepath

the_output = `ruby #{solution_filepath}`

if options.fetch(:benchmarks, false)
  Benchmark.bm do |x|
    x.report { puts block&.call(input_file) }
  end
end

result = with_result(options.merge(input_file: input_file), &block)

puts result

File.write(output_filepath, "#{result}\n")

def with_result(options = {}, &block)
  input_file = options.fetch(:input_file)


  block&.call input_file
end
