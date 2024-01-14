require './lib/board'
require './lib/player'

module ConnectFour
  # This class represents the game logic
  class Game
    attr_reader :board, :player_one, :player_two

    def initialize(player_one_symbol = "\u{1F534}", player_two_symbol = "\u{1F535}")
      @board = Board.new
      @player_one = Player.new("Player 1", player_one_symbol)
      @player_two = Player.new("Player 2", player_two_symbol)
    end

    def start
      play_game
    end

    private

    def play_game
      @current_player = player_one
      until board.game_end?(player_one, player_two)
        swap_turn
        display_board
        input = @current_player.get_input(1, board.column_length) - 1
        board.drop_disc(input, @current_player)
      end
      display_board
      display_winner
    end

    def display_board
      puts '----------------------------'
      board.display_board("\u{26AB}")
      puts '----------------------------'
    end

    def display_winner
      case board.winner(player_one, player_two)
      when player_one then puts "#{player_one.name} #{player_one.disc} WON the game!"
      when player_two then puts "#{player_two.name} #{player_two.disc} WON the game!"
      when nil then puts "The game is a DRAW!"
      end
    end

    def swap_turn
      @current_player = @current_player == player_one ? player_two : player_one
    end
  end
end
