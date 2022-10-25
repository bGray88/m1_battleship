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

    it 'automatically populates computer ships' do
      game = Game.new
    
      expect(game.com_board.render(true).count('S')).to eq(5)
    end
  end

  describe '#reset_game' do
    it 'it recreates player and computer boards' do
      game = Game.new
      
      expect(game.com_board.render(true).count('S')).to eq(5)

      game.reset_game

      expect(game.com_board.render(true).count('.')).to eq(11)
      expect(game.com_board.render.count('S')).to eq(0)
    
      expect(game.player_ships[0]).to be_an_instance_of(Ship)
      expect(game.player_board).to be_an_instance_of(Board)
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

    expect(game.game_end).to eq(false)

    game.player_ships[0].hit
    game.player_ships[1].hit
    game.player_ships[0].hit
    game.player_ships[1].hit
    game.player_ships[0].hit

    expect(game.game_end).to eq(true)
    end
  end
end
