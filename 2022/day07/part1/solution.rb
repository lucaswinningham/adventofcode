require 'solution_file'

require_relative './file_system'

SolutionFile.with __dir__ do |input|
  fs = FileSystem.recreate(input)

  memory = 0

  fs.tree_d(fs.root) do |dir|
    size = dir.size

    memory += size if size <= 100_000
  end

  memory
end
