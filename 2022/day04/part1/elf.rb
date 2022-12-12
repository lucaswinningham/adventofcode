Elf = Struct.new(:start, :stop, keyword_init: true) do
  def cover?(other_elf)
    start <= other_elf.start && other_elf.stop <= stop
  end
end
