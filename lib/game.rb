class Game
  attr_reader :welcome

  def initialize(welcome)
    @welcome = welcome
  end

  def game_end
    if @game_end == true
      @welcome
    end
  end
end
