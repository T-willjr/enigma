require 'pry'
require 'date'
class Enigma
  attr_reader :encrypted_message, :random_key

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @shift_hash = Hash.new(0)
    @number = 0
    @encrypted_message = nil
    @random_key = nil
  end

  def key_generator
    numbers = (0..9).to_a
    @random_key = numbers.sample(5).join
  end

  def split_key(key)
    array = []
    #binding.pry
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
    key_array = split_key(key)
    @shift_hash[:A] = key_array[0] + offset_array[0].to_i
    @shift_hash[:B] = key_array[1] + offset_array[1].to_i
    @shift_hash[:C] = key_array[2] + offset_array[2].to_i
    @shift_hash[:D] = key_array[3] + offset_array[3].to_i
    @shift_hash
  end
  #exfml qpody"

  def encryptor(message, key, date =Date.today.strftime("%d%m%y"))
    offset = date_to_offset(date)
    final_shift(key, offset)
    encrypted_message_array = []
    message_array = message.downcase.chars
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
    @encrypted_message = encrypted_message_array.join
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

  def encrypt(message, key =key_generator, date =Date.today.strftime("%d%m%y"))
    {
      encryption: encryptor(message, key, date),
      key: key,
      date: date
    }
  end

  def decryptor(message, key, date)
    offset = date_to_offset(date)
    final_shift(key, offset)
    message_array = message.downcase.chars
    decrypted_message_array = []
    message_array.each { |letter|
      if letter == " "
        if @number == 4
          @number = 0
        else
          @number += 1
        end
        decrypted_message_array << letter
      elsif @alphabet.include?(letter)
        decrypted_message_array << decrypted_letter(letter)
      else
        if @number == 4
          @number = 0
        else
          @number += 1
        end
        decrypted_message_array << letter
      end
    }
    decrypted_message_array.join
  end

  def decrypted_letter(letter)
    @number += 1
    if @number == 1
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:A])[0]
    elsif @number == 2
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:B])[0]
    elsif @number == 3
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:C])[0]
    elsif @number == 4
      @number = 0
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:D])[0]
    end
    letter_decrypted
  end

  def decrypt(message, key, date)
    {
      decryption: decryptor(message, key, date),
      key: key,
      date: date
    }
  end
end
