class Rectangle
  def initialize(width, length)
    @width = width
    @length = length
  end

  def area
    @width * @length
  end

  def perimeter
    2 * (@width + @length)
  end
end
