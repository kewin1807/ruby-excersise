require_relative './player'

# class Tictactoe
class TicTacToe
  def initialize
    @board = Array.new(9, ' ')
    @player_x = Player.new('X')
    @player_o = Player.new('O')
    @turn = Random.rand(1..2)
    @current_player_name = @turn == 1 ? 'X' : 'O'
  end

  # board method and displays
  def draw_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '---+---+---'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '---+---+---'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def game_over
    if @player_x.winner?
      'Player X win'
    elsif @player_o.winner?
      'Player O win'
    elsif @board.all? { |element| element != ' ' }
      'DRAW'
    else
      'CONTINUE'
    end
  end

  def switch_player
    @current_player_name = @current_player_name == 'X' ? 'O' : 'X'
  end

  def move_player
    loop do
      puts "Player #{@current_player_name}, please enter your move (1-9):"
      input = gets.chomp.to_i - 1

      if input.between?(0, 8) && @board[input] == ' '
        @board[input] = @current_player_name
        if @current_player_name == 'X'
          @player_x.update_user_state((input + 1).to_s)
        else
          @player_o.update_user_state((input + 1).to_s)
        end
        break
      else
        puts "Invalid move. Please try again."
      end
    end
  end

  def play
    puts 'Starting to play new game'
    @turn = Random.rand(1..2)
    @current_player_name = @turn == 1 ? 'X' : 'O'
    draw_board
    loop do
      move_player
      draw_board
      if game_over != 'CONTINUE'
        puts game_over
        break
      else
        switch_player
      end
    end
  end
end
