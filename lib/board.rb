module ConnectFour
  # This class represents the Board of a Connect Four game
  class Board
    attr_reader :row_length, :column_length, :board

    def initialize
      @row_length = 6
      @column_length = 7
      @board = Array.new(column_length) { Array.new(row_length) }
    end

    def drop_disc(col, player)
      return unless valid_column?(col)

      row = lowest_available_position(col)
      set_cell(player.disc, row, col)
    end

    def valid_column?(col)
      return false unless col >= 0 && col < column_length

      !column_full?(col)
    end

    def player_won?(player)
      # Check for a win horizontally
      @board.each do |row|
        return true if consecutive_discs?(row, player)
      end

      # Check for a win vertically
      @board.transpose.each do |column|
        return true if consecutive_discs?(column, player)
      end

      (0...@column_length).each do |column|
        (0...@row_length).each do |row|
          return true if consecutive_discs?(diagonal_left_to_right(column, row), player)
        end
      end

      (0...@column_length).each do |column|
        (0...@row_length).each do |row|
          return true if consecutive_discs?(diagonal_right_to_left(column, row), player)
        end
      end

      false
    end

    def draw?
      @board.all? { |col| column_full?(col) }
    end

    # Returns the winner player or nil for a draw
    def winner(player1, player2)
      return player1 if player_won?(player1)

      return player2 if player_won?(player2)

      nil if draw?
    end

    def display_board(default = "\u{2B55}")
      puts @board.transpose.map { |col| col.map { |cell| default if cell.nil?}.join('')}.join("\n")
    end

    private

    def diagonal_left_to_right(start_col, start_row)
      diagonal = []
      while start_row < @row_length && start_col < @column_length
        diagonal << @board[start_col][start_row]
        start_row += 1
        start_col += 1
      end
      diagonal
    end

    def diagonal_right_to_left(start_col, start_row)
      diagonal = []
      while start_col < @column_length && start_row >= 0
        diagonal << @board[start_col][start_row]
        start_row -= 1
        start_col += 1
      end
      diagonal
    end

    def consecutive_discs?(line, player)
      line.join('').include?(player.disc * 4)
    end

    def set_cell(value, row, col)
      @board[col][row] = value
    end

    def column_full?(col)
      return @board[col].all? { |cell| !cell.nil? } if col.is_a?(Integer)

      col.all? { |cell| !cell.nil? } if col.is_a?(Array)
    end

    def lowest_available_position(col)
      return unless valid_column?(col)

      @board[col].reverse.each_with_index.find { |cell, row| cell.nil? }&.yield_self { |_, row| row.nil? ? nil : row_length - 1 - row }
    end
  end
end
