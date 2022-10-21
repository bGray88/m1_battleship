require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  describe '#initialize' do
    it 'exit' do
    game = Game.new

    expect(game).to be_an_instance_of(Game)
    end
  end

  xit 'repeats welcome at game end' do
    game = Game.new

    expect(game_end).to be_an_instance_of(Game)
  end
end
