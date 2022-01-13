require 'pry'
class Enigma

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @shift_hash = Hash.new(0)
    @number = 0
  end

  def key_generator
    numbers = (0..9).to_a
    numbers.sample(5).join
  end

  def split_key(key)
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

  def final_shift(key, offset)
    offset_array = offset.chars
    @shift_hash[:A] = key[0] + offset[0].to_i
    @shift_hash[:B] = key[1] + offset[1].to_i
    @shift_hash[:C] = key[2] + offset[2].to_i
    @shift_hash[:D] = key[3] + offset[3].to_i
    @shift_hash
  end

  def encryptor(message, key, date)
    message_array = message.downcase.chars
    encrypted_message_array = []
    message_array.each { |letter|
      if letter == " "
        if @number == 4
          @number = 0
        else
          @number += 1
        end
        encrypted_message_array << letter
      elsif @alphabet.include?(letter)
        encrypted_message_array << encrypted_letter(letter)
      else
        if @number == 4
          @number = 0
        else
          @number += 1
        end
        encrypted_message_array << letter
      end
    }
    encrypted_message_array.join
  end

  def encrypted_letter(letter)
    @number += 1
    if @number == 1
      letter_index = @alphabet.index(letter)
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:A])[0]
    elsif @number == 2
      letter_index = @alphabet.index(letter)
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:B])[0]
    elsif @number == 3
      letter_index = @alphabet.index(letter)
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:C])[0]
    elsif @number == 4
      @number = 0
      letter_index = @alphabet.index(letter)
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:D])[0]
    end
    letter_encrypted
  end

  def encrypt(message, key, date)
    {
      encryption: encryptor(message, key, date),
      key: key,
      date: date
    }
  end
end
