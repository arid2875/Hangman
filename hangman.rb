require 'sinatra'

class Hangman  
  

  def initialize(guesses=8)
    dictionary = load_dictionary
    @random_word = dictionary[rand(@@dictionary.length-1)].downcase.split("")
    @board = []
    @guessed_letters = []
    @remaining_guesses = guesses
    @random_word.each do
      @board << "_"
    end    
  end

  attr_accessor :random_word
  attr_accessor :board
  attr_accessor :guessed_letters
  attr_accessor :remaining_guesses

  def load_dictionary
    dictionary = []

    File.readlines('dictionary.txt').each do |line| 
      if line.chomp.length.between?(5,12)
        dictionary << line.chomp
      end
    end
    
    dictionary
  end

  # def start
    
  #   selection = 0
    
  #   until selection == '1' || selection == '2'
  #     puts "Press 1 for a new game, or 2 to open a saved game"
  #     selection = gets.chomp
  #   end

  #   if selection == '1'
  #     play
  #   elsif selection == '2'
  #     select_save
  #   end     
  # end
    
  # def save
  #   puts "What would you like to name your game?"
  #   filename = 'Saves/' + gets.chomp            
  #   file = File.open(filename, 'w') {|f| f.write(YAML.dump(@hangman))}      
  # end

  # def play
  #   until game_over?
  #     take_turn
  #   end
  #   display_winner
  # end

  # def open(filename)
  #   filename = 'Saves/' + filename
  #   @hangman = YAML.load(File.read(filename))
  #   play
  # end

  # def select_save
  #   display_saves
  #   puts "Which file would you like to load?"
  #   save = gets.chomp
  #   validate_saved_filename(save)
  # end

  # def validate_saved_filename(filename)
  #   files_array = [] 
  #   Dir.foreach('Saves') {|file| files_array.push(file)}
  #   if files_array.include? filename
  #     open(filename)
  #     puts "#{filename} opened successfully!"
  #   else 
  #     puts "Invalid Filename!!"
  #     start
  #   end
  # end

  # def display_saves
  #   Dir.foreach('Saves') {|file| puts file} 
  # end

  # def take_turn          
  #   display_board
  #   display_guessed_letters

  #   validate_guess(guess)          
  # end
    
  # def save_and_close
  #   save
  #   abort
  # end

  # def game_over?
  #   if @hangman.remaining_guesses == 0 || !@hangman.board.include?("_")
  #     true
  #   else
  #     false
  #   end
  # end

  # def display_winner

  #   @hangman.board = @hangman.random_word.join("")
  #   message = ''
  #   if @hangman.remaining_guesses > 0   
  #     message = "Player wins!"
  #   else
  #     message = "Computer wins"
  #   end
  #   message
  # end

  def display_board
    @board.join(" ")  
  end

  def display_guessed_letters
    @guessed_letters.sort.join(",")
  end

  def validate_guess(guess)
    message = ''
    if (guess.length == 1 && guess.is_a?(String))
      if @guessed_letters.include? guess
        message = "You've already guessed the letter '#{guess}'"    
      else
        message = guess_letter(guess)
      end
    else 
      message = "Invalid guess!"  
    end
    message 
  end

  def guess_letter(guess)

    @guessed_letters << guess 
    correct = false
    message = ''
    @random_word.each_with_index do |letter, index|
      if letter == guess
        @board[index] = letter
        correct = true
        message = "There is an #{guess}!"
      end    
    end
    
    unless correct     
      @remaining_guesses -= 1
      message = "No '#{guess}'"
    end
    message
  end


  



 

end
