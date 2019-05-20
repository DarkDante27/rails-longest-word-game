require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    string_letters = params[:letters]
    splited_letters = string_letters.split(' ')
    user_word = @word.split(//)
    true_s = user_word.all? do |lett|
      splited_letters.include?(lett)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json_results = open(url).read
    result = JSON.parse(json_results)
    if true_s && result['found']
      @message = 'You win'
    elsif !true_s
      @message = 'The word does not match the given letters'
    else
      @message = 'The word does not exist. You Lose!'
    end
  end
end
