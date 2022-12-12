require 'solution_file'

require_relative './file_system'

SolutionFile.with __dir__ do |input|
  fs = FileSystem.recreate(input)

  total_space = 70_000_000
  needed_space = 30_000_000
  unused_space = total_space - fs.root.size
  space_to_delete = needed_space - unused_space

  target_size = total_space

  fs.tree_d(fs.root) do |dir|
    size = dir.size

    target_size = size if space_to_delete <= size && size < target_size
  end

  target_size
end
