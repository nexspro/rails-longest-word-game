require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    word = params[:word].upcase
    letters = params[:letters].split("")
    valid_letters = word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }

    if valid_letters
      url = "https://dictionary.lewagon.com/#{word}"
      response = URI.open(url).read
      json = JSON.parse(response)
      @valid_word = json["found"]
    end

    if @valid_word
      @message = "Congratulations! #{word} is a valid English word!"
    elsif valid_letters
      @message = "Sorry, the word #{word} is not a valid English word!"
    else
      @message = "Sorry, but #{word} can't be built out of #{letters.join(', ')}"
    end
  end
end
