require 'rspec'
require './lib/ship'
require './lib/cell'
# require './lib/board'
require './lib/game'

RSpec.describe Game do
  describe '#initialize' do
    it 'has a welcome message' do
    greeting = Game.new("Welcome to BATTLESHIP--Enter p to play. Enter q to quit")

    expect(greeting.welcome).to eq("Welcome to BATTLESHIP--Enter p to play. Enter q to quit")
    end
  end


end
