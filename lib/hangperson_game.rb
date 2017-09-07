class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @wrong_guesses = ''
    @guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(letter)
    if not letter =~ /[a-z]/i
      raise ArgumentError
    elsif letter.length == 0
      raise ArgumentError
    elsif letter.nil?
      raise ArgumentError
    end
    letter.downcase!
    if @guesses.include? letter
      return false
    elsif @wrong_guesses.include? letter
      return false
    end
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  end
  
  def word_with_guesses
    result = ''
    @word.each_char do |letter|
      if @guesses.include? letter
        result << letter
      else
        result << '-'
      end
    end
    result
  end
  
  def check_win_or_lose
    test_word = word_with_guesses
    if @word == test_word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
  
  
end
