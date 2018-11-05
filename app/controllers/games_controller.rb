require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end

  def score
    @letters = params[:letters].split
    @answer = params[:answer]
    if grid_check(@answer, @letters) == false
      @message = "Sorry but #{params[:answer]} can not be built"
    elsif check_word(@answer) == false
      @message = "Sorry but #{params[:answer]} is not an English word"
    else
      @message = 'Well done'
    end
  end

  def check_word(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end

  def grid_check(attempt, grid)
    attempt.upcase.chars.all? { |l| attempt.upcase.count(l) <= grid.count(l) }
  end
end
