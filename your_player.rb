require './base_player.rb'

class YourPlayer < BasePlayer
  def next_point(time:)
    # Implement your strategy here.
    {
      row: 0,
      col: 0
    }
  end

  def grid
    game.grid
  end
end
