require 'sinatra'
require_relative 'hangman'

# enable :sessions
# set :session_secret, 'hellothere12345'
@@hangman = Hangman.new

get '/' do  
  
  guess = params["guess"].to_s.downcase
  message = @@hangman.validate_guess(guess)    
  erb :index, :locals => {:guesses => @@hangman.remaining_guesses, :board => @@hangman.display_board, :guessed => @@hangman.display_guessed_letters, :message => message} 
  
  # def take_turn(guess)          
  #   display_board
  #   display_guessed_letters         
  #   validate_guess(guess)          
  # end

end

def refresh
  @@hangman = Hangman.new
end