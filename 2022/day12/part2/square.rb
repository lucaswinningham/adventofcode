Square = Struct.new(:elevation, :row, :col, :successor, keyword_init: true) do
  def to_s
    "(#{row},#{col})"
  end
end
