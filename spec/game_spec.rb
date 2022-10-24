require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  describe '#initialize' do
    it 'exist' do
      game = Game.new

      expect(game).to be_an_instance_of(Game)
    end
  end

 describe '#set boards' do
    it 'creates player and computer boards' do
      game = Game.new
    
      expect(game.player_board).to be_an_instance_of(Board)
    end
  end

  describe '#set ships' do
    it 'creates player and computer ships' do
      game = Game.new
      
      expect(game.player_ships[0]).to be_an_instance_of(Ship)
    end
  end

  describe '#com_place_ships' do
    it 'automatically populates player ships' do
      game = Game.new
      game.com_place_ships
    
      expect(game.com_board.render(true).count('S')).to eq(5)
    end
  end

  describe '#com_shot' do
    it 'automatically shoots at player ships' do
      game = Game.new

      expect(game.player_board.valid_coordinate?(game.com_shot)).to be true
    end
  end

  describe '#game_end' do
    it 'determines if the game is over' do
    game = Game.new
    game.player_ships[0].hit
    game.player_ships[1].hit
    game.player_ships[0].hit
    game.player_ships[1].hit
    game.player_ships[0].hit

    expect(game.game_end).to eq(:c_wins)
    end
  end
end
