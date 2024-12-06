#!/usr/bin/env ruby

require 'benchmark'
require 'fileutils'
require 'optparse'
require 'time'

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

  opts.on('-d DAY', '--day=DAY', 'Day of challenge, defaults to current day', Numeric) do |v|
    options[:day] = v
  end

  opts.on('-p PART', '--part=PART', 'Part of challenge, required', Numeric) do |v|
    options[:part] = v
  end

  opts.on('-j', '--[no-]jog', 'Run using the example input, defaults to false') do |v|
    options[:jog] = v
  end

  opts.on('-h', '--help', 'Prints this help') { puts(opts).tap { exit } }
end

option_parser.parse!

root = options.fetch(:root) { File.expand_path('..', __dir__) }
year = options.fetch(:year) { Date.today.year }
day = options.fetch(:day) { Date.today.year }
part = options.fetch(:part) { puts(option_parser.help).tap { exit 1 } }
jog = options.fetch(:jog, false)

year_directory = "#{root}/#{year}"
day_directory = "#{year_directory}/day#{day.to_s.rjust(2, '0')}"
part_directory = "#{day_directory}/part#{part}"

solution_filepath = "#{part_directory}/#{Constants.solution_filename}"
input_filepath = if jog
  "#{day_directory}/#{Constants.example_input_filename}"
else
  "#{part_directory}/#{Constants.input_filename}"
end

require solution_filepath

input = File.read(input_filepath)

answer = nil

realtime = Benchmark.realtime { answer = "Answer: #{Solution.call(input)}" }
elapsed_time = realtime.round(3).to_f
benchmark_report = "Took #{elapsed_time} seconds."

puts answer
puts benchmark_report

log_directory = "#{root}/log"
year_directory = "#{log_directory}/#{year}"
day_directory = "#{year_directory}/day#{day.to_s.rjust(2, '0')}"
part_filename = "#{day_directory}/part#{part}.log"

FileUtils.mkdir_p day_directory
FileUtils.touch part_filename

log_entry = "[#{Time.now.iso8601}]:\n"
log_entry += "\t#{answer}\n"
log_entry += "\t#{benchmark_report}\n"
log_entry += "\n"

File.write(part_filename, log_entry, mode: File::WRONLY|File::CREAT|File::APPEND)
