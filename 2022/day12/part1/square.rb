Square = Struct.new(:elevation, :row, :col, :g_score, :h_score, :predecessor, keyword_init: true) do
  def f_score
    g_score + h_score
  end
end
