require 'pry'

class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
  attr_accessor :case_number, :value

  def initialize(case_number)
    #TO DO doit régler sa valeur, ainsi que son numéro de case
    @case_number = case_number
    @value = " "
  end

  def to_s
    #TO DO : doit renvoyer la valeur au format string

  end

end

class Board
  include Enumerable
  #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  attr_accessor :boardcases

  def initialize
    #TO DO :
    #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
    #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
    @boardcases = []
    i = 0
    while i < 9 do
      @boardcases << BoardCase.new(i)
      i += 1
    end
  end

  def display
  #TO DO : afficher le plateau
  puts "-------------"
  puts "| #{boardcases[0].value} | #{boardcases[1].value} | #{boardcases[2].value} |"
  puts "|-----------|"
  puts "| #{boardcases[3].value} | #{boardcases[4].value} | #{boardcases[5].value} |"
  puts "|-----------|"
  puts "| #{boardcases[6].value} | #{boardcases[7].value} | #{boardcases[8].value} |"
  puts "-------------"
  puts puts "*" * 40 +" <3"

  end

  def play
    #TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)


  end

  def victory?(played_cases, player)
    #TO DO : qui gagne ?

    if played_cases != nil
      win_state = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
      win_state.each do |line|
        if (line & played_cases).size == 3
          puts "#{player.name} a gagné !"
          return true
        end
        #binding.pry
      end
      return false
    end
  end
end


class Player
  attr_accessor :name, :symbol, :played_cases

  @@symbols = []

  def initialize
    @played_cases = []
      if @@symbols.size == 0
    puts "Player 1: what's your name ?"
    @name = gets.chomp
    while !%w(X O).include?(@symbol) do
      puts "Choose a symbol (X or O)"
      @symbol = gets.chomp.to_s.upcase
    end
    puts "player 1 symbol: #{@symbol}"
    @@symbols << @symbol
      else
      puts "Player 2: what's your name ?"
      @name = gets.chomp
      @symbol = (%w(X O) - @@symbols)[0]
      puts "player 2 symbol: #{@symbol}"
    end
  end
end

class Game
  def initialize
    #TO DO : créé 2 joueurs, créé un board
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
    @free_cases = (1..9).to_a
  end

  def go
    # TO DO : lance la partie
    puts "Rules, enjoy!"
    puts "here is your board, just choose your case and win!"
    puts "-------------"
    puts "| 1 | 2 | 3 |"
    puts "|-----------|"
    puts "| 4 | 5 | 6 |"
    puts "|-----------|"
    puts "| 7 | 8 | 9 |"
    puts "-------------"
    puts "=" * 40

    a = [@player1, @player2]
    rand = rand(0..1)
    @board.display
    while !@board.victory?(a[rand].played_cases, a[rand]) do
      turn(a.rotate![rand])
    end
  end

  def turn(player)
    #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    puts "A toi #{player.name}!"
    input = gets.chomp.to_i
    while !@free_cases.include?(input)
      puts "Essaye encore!"
      input = gets.chomp.to_i
    end
    @free_cases -= [input]
    @board.boardcases[input - 1].value = player.symbol
    #On remplace la valeur du boardcase " " contenu dans l'array boardcases,
    #variable de l'instance @board, par le symbole du joueur
    player.played_cases << input - 1
    @board.display
  end
end

Game.new.go
