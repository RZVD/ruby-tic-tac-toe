class Board
    attr_reader :board

    WIN_CONDITIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    def initialize
        @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def place_symbol(player, move)
        player_symbol = player.symbol

        if @board[move - 1] != player_symbol
            @board[move - 1] = player_symbol
        end
        
        winning_move?
    end             

    def print_board
        puts <<-HEREDOC
       #{board[0]} | #{board[1]} | #{board[2]}
      ---+---+---
       #{board[3]} | #{board[4]} | #{board[5]}
      ---+---+---
       #{board[6]} | #{board[7]} | #{board[8]}
        HEREDOC
    end
    
    private 
    def winning_move?
        WIN_CONDITIONS.any? do |cond|
            [board[cond[0]], board[cond[1]], board[cond[2]]].uniq.length == 1
        end
    end
end

class Player
    attr_reader :name, :symbol
    public
    
    def initialize(name, symbol)
        @symbol = symbol
        @name = name
    end
end

board = Board.new
player1 = Player.new("test", 'X')
board.place_symbol(player1, 5)
board.place_symbol(player1, 6)
board.place_symbol(player1, 4)

board.print_board




#123
#456
#789