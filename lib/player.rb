module ConnectFour
  # This class represents a player in Connect Four
  class Player
    attr_reader :name, :disc

    def initialize(name, symbol)
      @name = name
      @disc = symbol
    end

    def get_input(min, max)
      puts "Enter a number between #{min} and #{max}"
      input = gets.chomp.to_i
      until (min..max).cover?(input)
        puts "Invalid number. Enter a number between #{min} and #{max}"
        input = gets.chomp.to_i
      end
      input
    end
  end
end
