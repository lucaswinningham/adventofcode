Tree = Struct.new(:height, :west, :east, :north, :south, keyword_init: true) do
  def score
    west * east * north * south
  end
end
