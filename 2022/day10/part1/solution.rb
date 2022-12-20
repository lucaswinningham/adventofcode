require 'solution_file'

require_relative './input'

SolutionFile.with __dir__ do |input|
  stream = Input.to_stream input

  num_addx = stream.count { |instruction| instruction[:name] == :addx }
  num_noop = stream.count { |instruction| instruction[:name] == :noop }
  num_instructions = 2 * num_addx + num_noop

  target_cycles = 20.step(num_instructions, 40).to_a

  next_target_cycle = target_cycles.shift
  cycle = 0
  register_value = 1
  signal_strength = 0

  stream.each do |instruction|
    case instruction[:name]
    when :addx
      cycle += 2
      register_value += instruction[:parameter]
    when :noop
      cycle += 1
    end

    if cycle == next_target_cycle - 2 || cycle == next_target_cycle - 1
      signal_strength += next_target_cycle * register_value
      next_target_cycle = target_cycles.shift

      break unless next_target_cycle
    end
  end

  signal_strength
end
