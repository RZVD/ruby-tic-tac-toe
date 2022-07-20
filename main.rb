
def is_alpha?(nr)
    [1,2,3,4,5,6,7,8,9].any? {|n| n == nr}
end

def is_full?(table)
    table.none? {|cell| is_alpha?(cell)}
end


class Board
    attr_reader :board
    attr_reader :won
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
        @won = false;
    end
    
    public
    
    def place_symbol(player, move)
        player_symbol = player.symbol

        if is_alpha? @board[move - 1]
            @board[move - 1] = player_symbol
        else puts "error, invalid move"
        end
        @won = winning_move?
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

class Game
    attr_reader :board
    attr_reader :player1
    attr_reader :player2
    attr_reader :current_player

    def initialize
        @board = Board.new
        @player1 = Player.new("Player1",'X') 
        @player2 = Player.new("Player2",'O')
        @current_player = @player1
    end

    def turn(move)
        @board.place_symbol(@current_player, move)
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end  
    end

end


game = Game.new()

until is_full?(game.board.board) || game.board.won
    move = gets.chomp.to_i
    game.turn(move)
    
    game.board.print_board
end






#123
#456
#789