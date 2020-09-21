class GamesController < ApplicationController

  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    @score = ""

    url = "https://wagon-dictionary.herokuapp.com/#{params["word"]}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    word_validity = JSON.parse(response)

    word_input = params["word"].split("")
    letters_combo = params["letters"].split

    word_input.all? do |letter|
      @true_combo = letters_combo.include?(letter)
    end
        if @true_combo && word_validity["found"] == false
          @score = "SORRY! #{params["word"]} is not a valid english word.. 😬"
        elsif @true_combo && word_validity["found"] == true
          @score = "Congrats! #{params["word"]} is a valid word!"
        else @true_combo == false
          @score = "SORRY! #{params["word"]} can't be built out of #{params["letters"]}"
      end
  end

end
