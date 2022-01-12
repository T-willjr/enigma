require 'pry'
class Enigma

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def key_generator
    numbers = (0..9).to_a
    numbers.sample(5).join
  end

end
