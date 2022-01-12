require 'pry'
class Enigma

  def initialize
    @numbers = (0..9).to_a
    @alphabet = ("a".."z").to_a << " "
  end

end
