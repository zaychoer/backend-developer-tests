require './base_player.rb'

class YourPlayer < BasePlayer
  def initialize(game:, name:)
    super
    @visited = {}
    @path_stack = []
  end

  def next_point(time:)
    if @path_stack.empty?
      # Initialize the first position
      @current_position = { row: 0, col: 0 }
      @path_stack.push(@current_position)
      return @current_position
    else
      # Continue exploring from the current position
      next_move = find_next_move(@current_position)
      if next_move
        @current_position = next_move
        @path_stack.push(@current_position)
      else
        @current_position = @path_stack.pop
      end
      return @current_position
    end
  end

  def grid
    game.grid
  end

  private

  def find_next_move(current_position)
    # Retrieve all valid moves from the current position
    possible_moves = grid.edges[current_position].keys

    # Filter out the moves that have already been visited
    possible_moves.reject! { |move| @visited[move] }

    # If there are unvisited moves, choose the one with the least cost
    if possible_moves.any?
      next_move = possible_moves.min_by { |move| grid.edges[current_position][move] }
      @visited[next_move] = true
      return next_move
    end

    # If no unvisited moves are available, return nil to backtrack
    nil
  end
end
