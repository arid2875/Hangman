
require 'sinatra'

get '/' do
      
  create
  #@guess = params["guess"].downcase    
  erb :index, :locals => {:guesses = @remaining_guesses} 

end



helpers do

  def load_dictionary
    dictionary = []
  	File.readlines('dictionary.txt').each do |line| 
  	  if line.chomp.length.between?(5,12)
  		  dictionary << line.chomp
  	  end
    end
    dictionary
  end  

  def create(guesses=8)
    
    @random_word = @@dictionary[rand(@@dictionary.length-1)].downcase.split("")
    @board = []
    @guessed_letters = []
    @remaining_guesses = guesses
    @random_word.each do
  	  @board << "_"
    end
  end

end

