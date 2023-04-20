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
    if included?(@word, grid)
      if english_word?(@word)
        @result = 'success'
      else
        @result = 'not english'
      end
    else
      @result = 'not possible'
    end
  end
end
