
require 'sinatra'

get '/' do
      
  create
  @guess = params["guess"].downcase    
  erb :index, :locals => {:guesses = @remaining_guesses} 

end

@@dictionary = []

attr_accessor :remaining_guesses
attr_accessor :board
attr_accessor :guessed_letters
attr_accessor :random_word

helpers do

  def load_dictionary
  	File.readlines('dictionary.txt').each do |line| 
  	  if line.chomp.length.between?(5,12)
  		  @@dictionary << line.chomp
  	  end
    end
  end  

  def create(guesses=8)

    load_dictionary
    @random_word = @@dictionary[rand(@@dictionary.length-1)].downcase.split("")
    @board = []
    @guessed_letters = []
    @remaining_guesses = guesses
    @random_word.each do
  	  @board << "_"
    end
  end

end

