require 'pry'
class Enigma

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def key_generator
    numbers = (0..9).to_a
    numbers.sample(5).join
  end

  def split(key)
    array = []
    array << key[0..1].to_i
    array << key[1..2].to_i
    array << key[2..3].to_i
    array << key[3..4].to_i
    array
  end

  def date_to_offset(date)
    date_squared = date.to_i ** 2
    number_array = date_squared.to_s.chars
    number_array.last(4).join
  end
end
