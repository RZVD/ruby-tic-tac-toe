
def is_alpha?(nr)
    [1,2,3,4,5,6,7,8,9].any? {|n| n == nr}
end

def is_full?(table)
    table.none? {|cell| is_alpha?(cell)}
end


class Board
    attr_reader :board
    attr_reader :won
    attr_reader :winner

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
        @winner = nil
    end
    
    public
    
    def place_symbol(player, move)
        player_symbol = player.symbol

        if is_alpha? @board[move - 1]
            @board[move - 1] = player_symbol
        else puts "error, invalid move"
            return 'err'
        end
        @won = winning_move?
        
        if @won 
            @winner = player 
        end
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
    attr_reader :grid
    attr_accessor :player1
    attr_accessor :player2
    attr_reader :current_player

    def initialize
        @grid = Board.new
        @player1 = Player.new("Player1",'X') 
        @player2 = Player.new("Player2",'O')
        @current_player = @player1
        @grid.print_board
    end
    private
    def turn(move)
        err = @grid.place_symbol(@current_player, move)
        if err == "err"
            return
        elsif @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end  
    end

    public
    
    def play
        until is_full?(grid.board) || grid.won
            puts "#{current_player.name}'s Turn"
            move = gets.chomp.to_i
            turn(move)
            grid.print_board
        end
        
        puts "\n\n #{grid.winner.name} Won!"

    end
end

replay = false

until replay
    game = Game.new()
    game.play()
    puts "Wanna play again? (y/n)"
    replay = gets.chomp.downcase == 'y' ? false : true; 

end
