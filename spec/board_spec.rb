require './lib/board'

describe ConnectFour::Board do
  let(:player_one) { double('Player', disc: "\u{1F534}") }
  let(:player_two) { double('Player', disc: "\u{2B24}") }

  describe '#initialize' do
    it 'initializes the board with the correct number of rows' do
      board = ConnectFour::Board.new
      expect(board.row_length).to eq(6)
    end

    it 'initializes the board with the correct number of columns' do
      board = ConnectFour::Board.new
      expect(board.column_length).to eq(7)
    end
  end

  describe '#valid_column?' do
    it 'returns false if a column is full' do
      board = ConnectFour::Board.new
      new_board = board.board
      new_board[0].map! { 'BL' }

      board.instance_variable_set(:@board, new_board)
      expect(board.valid_column?(0)).to eq(false)
    end

    it 'returns true if a column is empty' do
      board = ConnectFour::Board.new
      expect(board.valid_column?(3)).to eq(true)
    end

    it 'returns true if a column has five empty slots' do
      board = ConnectFour::Board.new
      new_board = board.board
      new_board[0] = [nil, 'BL', 'BL', 'BL', 'BL', 'BL']

      board.instance_variable_set(:@board, new_board)
      expect(board.valid_column?(0)).to eq(true)
    end

    it 'returns false if a column is out of range' do
      board = ConnectFour::Board.new
      expect(board.valid_column?(9)).to eq(false)
    end
  end

  describe '#drop_disc' do
    it 'adds a new disc to the lowest row in the column' do
      board = ConnectFour::Board.new
      expect { board.drop_disc(0, player_one) }.to(change { board.board })
    end

    it 'adds a new disc to the lowest row in the column when there are 5 discs already' do
      board = ConnectFour::Board.new
      5.times { board.drop_disc(0, player_one) }
      expect { board.drop_disc(0, player_one) }.to(change { board.board })
    end

    it 'does not add a new disc to the column when it is full' do
      board = ConnectFour::Board.new
      6.times { board.drop_disc(0, player_one) }
      expect { board.drop_disc(0, player_one) }.not_to(change { board.board })
    end
  end

  describe '#draw?' do
    it 'returns true if all the columns are full' do
      board = ConnectFour::Board.new
      board.instance_variable_set(:@board, Array.new(7) { Array.new(6, "\u{1F534}") })
      expect(board.draw?).to eq(true)
    end

    it 'returns false if all the columns are nil' do
      board = ConnectFour::Board.new
      expect(board.draw?).to eq(false)
    end

    it 'returns false if most of the columns are nil' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6, "\u{1F534}") }
      new_board[0] = Array.new(6)
      new_board[3][0] = nil

      board.instance_variable_set(:@board, new_board)
      expect(board.draw?).to eq(false)
    end
  end

  describe '#player_won?' do
    it 'returns true if player has 4 discs in a row vertically' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][0] = "\u{1F534}"
      new_board[0][1] = "\u{1F534}"
      new_board[0][2] = "\u{1F534}"
      new_board[0][3] = "\u{1F534}"

      board.instance_variable_set(:@board, new_board)
      expect(board.player_won?(player_one)).to eq(true)
    end

    it 'returns true if player has 4 discs in a row horizontally' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][0] = "\u{1F534}"
      new_board[1][0] = "\u{1F534}"
      new_board[2][0] = "\u{1F534}"
      new_board[3][0] = "\u{1F534}"

      board.instance_variable_set(:@board, new_board)
      expect(board.player_won?(player_one)).to eq(true)
    end

    it 'returns false if player only has 3 discs in a row horizontally' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][0] = "\u{1F534}"
      new_board[1][0] = "\u{1F534}"
      new_board[2][0] = "\u{1F534}"

      board.instance_variable_set(:@board, new_board)
      expect(board.player_won?(player_one)).to eq(false)
    end

    it 'returns true if player has 4 discs in a diagonal left to right' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][0] = "\u{1F534}"
      new_board[1][1] = "\u{1F534}"
      new_board[2][2] = "\u{1F534}"
      new_board[3][3] = "\u{1F534}"

      board.instance_variable_set(:@board, new_board)
      expect(board.player_won?(player_one)).to eq(true)
    end

    it 'returns true if player has 4 discs in a diagonal right to left' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][5] = "\u{1F534}"
      new_board[1][4] = "\u{1F534}"
      new_board[2][3] = "\u{1F534}"
      new_board[3][2] = "\u{1F534}"

      board.instance_variable_set(:@board, new_board)
      expect(board.player_won?(player_one)).to eq(true)
    end
  end

  describe '#winner' do
    it 'returns player1 if player1 won the game' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][5] = player_one.disc
      new_board[1][4] = player_one.disc
      new_board[2][3] = player_one.disc
      new_board[3][2] = player_one.disc

      board.instance_variable_set(:@board, new_board)
      expect(board.winner(player_one, player_two)).to eq(player_one)
    end

    it 'returns player2 if player2 won the game' do
      board = ConnectFour::Board.new
      new_board = Array.new(7) { Array.new(6) }
      new_board[0][0] = player_two.disc
      new_board[1][0] = player_two.disc
      new_board[2][0] = player_two.disc
      new_board[3][0] = player_two.disc

      board.instance_variable_set(:@board, new_board)
      expect(board.winner(player_one, player_two)).to eq(player_two)
    end

    it 'returns player2 if player2 won the game' do
      board = ConnectFour::Board.new
      board.instance_variable_set(:@board, Array.new(7) { Array.new(6) })

      expect(board.winner(player_one, player_two)).to eq(nil)
    end
  end
end
