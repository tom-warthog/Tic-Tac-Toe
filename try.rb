class Player
  #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
  attr_accessor :name, :symbol
  attr_writer :win
  @@symbols = []

  def initialize
    #TO DO : doit régler son nom, sa valeur, son état de victoire
    puts "hi dude, what's your name please? "
    @name = gets.chomp
    while @symbol != "X" || @symbol != "O"
       puts "Please select a value (X or O)"
       @@symbols << @symbol = gets.chomp.upcase
    next
    if @@symbols[0] == "O"
      @symbol = "X"
    elsif @@symbols[0] == "X"
      @symbol = "O"
    # else @symbol != "O" || @symbol != "X"
    #   puts "Please open your eyes when you read the instruction!"

    end
  end
end

player1 = Player.new
player2 = Player.new
 p player1
 p player2
