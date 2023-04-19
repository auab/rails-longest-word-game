class GamesController < ApplicationController

  def new
    alphabet_array = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet_array.sample }
  end

  def score
    # @word = params[:word]
    # word_splitted = @word.split('')
    # if
  end

end
