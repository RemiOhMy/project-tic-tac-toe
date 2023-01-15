def prompt(*args)
  print(*args)
  gets.chomp
end

WIN_CONDITIONS = [
  [1, 2, 3],
  [1, 5, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 5, 7],
  [3, 6, 9],
  [4, 5, 6],
  [7, 8, 9]
].freeze

class Player
  attr_reader :name, :marker

  def initialize(marker)
    @name = prompt 'Please enter player name: '
    @marker = marker
    puts "Player #{@name} set - #{@marker}"
  end
end

class Board
  attr_reader :current_player

  def initialize
    @board_spots = {
      1 => '1',
      2 => '2',
      3 => '3',
      4 => '4',
      5 => '5',
      6 => '6',
      7 => '7',
      8 => '8',
      9 => '9'
    }

    start_game
  end

  def print_board
    puts "\n #{@board_spots[1]} | #{@board_spots[2]} | #{@board_spots[3]} "
    puts '-----------'
    puts " #{@board_spots[4]} | #{@board_spots[5]} | #{@board_spots[6]} "
    puts '-----------'
    puts " #{@board_spots[7]} | #{@board_spots[8]} | #{@board_spots[9]} \n\n"
  end

  def start_game
    puts 'Player One (X)'
    @player1 = Player.new('X')
    puts 'Player Two (O)'
    @player2 = Player.new('O')

    @current_player = @player1
    play_game
  end

  def play_game
    loop do
      print_board

      puts "#{@current_player.name}\'s turn!"

      place_marker

      break if victory_check

      switch_player
    end
  end

  def switch_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end

  def victory_check
    WIN_CONDITIONS.each do |win_con|
      if @board_spots.values_at(*win_con).uniq.size <= 1
        puts "Winner! #{@current_player.name} wins!"
        return true
      end
    end
    false
  end

  def place_marker
    loop do
      choice = (prompt 'Choose a spot (1-9): ').to_i

      if choice >= 1 && choice <= 9
        if @board_spots[choice] == choice.to_s
          @board_spots[choice] = @current_player.marker
          break
        else
          puts 'Spot already taken!'
        end
      else
        puts 'Invalid Choice!'
      end
    end
  end
end

Board.new
