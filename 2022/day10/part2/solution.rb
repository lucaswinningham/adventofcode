require 'solution_file'

require_relative './cpu'

SCREEN_WIDTH = 40

SolutionFile.with __dir__ do |input|
  CPU.instructions = input.split("\n")
  screen = []

  while CPU.running?
    CPU.tick do
      # 3 pixels wide with horizontal position at middle pixel
      next_pixel_position = screen.length % SCREEN_WIDTH
      sprite_position_range = (CPU.register.value - 1)..(CPU.register.value + 1)
      pixel = sprite_position_range.include?(next_pixel_position) ? '#' : '.'

      screen.push pixel
    end
  end

  screen.each_slice(SCREEN_WIDTH).map(&:join).join("\n")
end
