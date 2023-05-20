# class Player
class Player
  @@wining_state = [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9'], ['1', '4', '7'], ['2', '5', '8'], ['3', '6', '9'], ['1', '5', '9'], ['3', '5', '7']]

  def initialize(name)
    @name = name
    @current_state = []
  end

  def update_user_state(current)
    @current_state << current
    p @current_state
  end

  def winner?
    is_winner = false
    @@wining_state.each do |win_state|
      if (win_state - @current_state).empty?
        is_winner = true
        break
      end
    end
    is_winner
  end

  def clear_user_state
    @current_state = []
  end
end
