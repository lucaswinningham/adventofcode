Elf = Struct.new(:start, :stop, keyword_init: true) do
  def contain?(other_elf)
    start <= other_elf.stop and other_elf.start <= stop
  end
end
