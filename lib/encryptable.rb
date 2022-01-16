module Encryptable
  def encryptor(message, key, date)
    offset = date_to_offset(date)
    final_shift(key, offset)
    message_array = message.downcase.chars
    @encrypted_message = encrypt_character_filter(message_array)
  end

  def encrypt_character_filter(message_array)
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

  def encrypt(message, key =key_generator, date =Date.today.strftime("%d%m%y"))
    @key = key
    @date = date
    @encrypted = {
      encryption: encryptor(message, key, date),
      key: key,
      date: date
    }
  end
end
