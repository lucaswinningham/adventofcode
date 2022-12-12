class FileSystem
  File = Struct.new(:name, :size, :dir, keyword_init: true) do
    def to_h
      {
        name: name,
        size: size
      }
    end
  end

  Dir = Struct.new(:name, :root, :dir, keyword_init: true) do
    def dirs
      @dirs ||= Hash.new { |h, k| h[k] = Dir.new(name: k, dir: self) }
    end

    def files
      @files ||= Hash.new { |h, k| h[k] = File.new(name: k, dir: self) }
    end

    def size
      dirs.values.sum(&:size) + files.values.sum(&:size)
    end

    def to_h
      {
        name: name,
        dirs: dirs.transform_values(&:to_h),
        files: files.transform_values(&:to_h)
      }
    end
  end

  attr_reader :pwd

  def cd(name)
    if name == '..'
      @pwd = pwd.dir
    elsif name == '/'
      @pwd = root
    else
      @pwd = pwd.dirs[name]
    end
  end

  def root
    @root ||= Dir.new root: true
  end

  def pwd
    @pwd ||= root
  end

  def mkdirp(name)
    pwd.dirs[name]
  end

  def touch(name, &block)
    pwd.files[name].tap(&block)
  end

  def tree_d(target_dir = pwd, &block)
    target_dir.dirs.values.each { |dir| tree_d(dir, &block) }

    block.call target_dir
  end

  def snapshot
    root.to_h
  end

  class << self
    def recreate(input)
      new.tap do |fs|
        input.split('$ ').reject(&:empty?).each do |command_with_output|
          command, *output = command_with_output.split("\n")
      
          if command.start_with? 'cd'
            fs.cd command.gsub('cd ', '')
          elsif command.start_with? 'ls'
            output.each do |ls_line|
              if ls_line.start_with? 'dir'
                fs.mkdirp ls_line.gsub('dir ', '')
              else
                size, name = ls_line.split
                fs.touch(name) { |file| file.size = size.to_i }
              end
            end
          end
        end
      end
    end
  end
end
