Tree = Struct.new(:height, :west, :east, :north, :south, keyword_init: true) do
  def obscured?
    west && east && north && south
  end

  def visible?
    !obscured?
  end
end
