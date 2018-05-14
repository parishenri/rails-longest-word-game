require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end

  def score
    @letters = params[:letters].split
    @guess = params[:guess].upcase
    message(@guess, @letters)
  end
end

def message(guess, letters)
  if included?(guess, letters)
    if english_word?(guess)
      @message = "well done"

    else
      @message = "not an english word"
    end
  else
      @message = "not in the grid"
  end
end

def included?(guess, letters)
  guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
end

def english_word?(guess)
  response = open("https://wagon-dictionary.herokuapp.com/#{guess}")
  json = JSON.parse(response.read)
  return json['found']
end

