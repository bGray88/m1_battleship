class Ship
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
  end

  def sunk?
    @health >= 1
    false
  end

end
