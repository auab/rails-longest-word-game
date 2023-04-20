require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet_array = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet_array.sample }
  end

  def included?(guess, grid)
    u = grid.count('a')
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @word = params[:word]
    grid = params[:grid]
    session[:score] ||= 0
    if included?(@word, grid)
      if english_word?(@word)

        @result = "Congratulations, #{@word.upcase} is a valid english word"
        session[:score ]+=1
      else
        @result = "Sorry, but #{@word.upcase} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry, but can't build #{@word.upcase} with #{grid.upcase.split('').join(', ')}"
    end
    @score = session[:score]
  end
end
