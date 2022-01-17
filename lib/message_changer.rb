module MessageChanger
  def message_generator(message, key, date)
    offset = date_to_offset(date)
    final_shift(key, offset)
    original_message_array = message.downcase.chars
    @new_message = character_filter(original_message_array)
  end

  def character_filter(original_message_array)
    new_message_array = []
    original_message_array.each { |letter|
      if letter == " "
        if @shift_count == 4
          @shift_count = 0
        else
          @shift_count += 1
        end
        new_message_array << letter
      elsif @alphabet.include?(letter) && @message_to_be_encrypted
        new_message_array << encrypted_letter(letter)
      elsif @alphabet.include?(letter) && @message_to_be_encrypted == false
        new_message_array << decrypted_letter(letter)
      else
        if @shift_count == 4
          @shift_count = 0
        else
          @shift_count += 1
        end
        new_message_array << letter
      end
    }
    new_message_array.join
  end

  def encrypted_letter(letter)
    @shift_count += 1
    letter_index = @alphabet.index(letter)
    if @shift_count == 1
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:A])[0]
    elsif @shift_count == 2
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:B])[0]
    elsif @shift_count == 3
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:C])[0]
    elsif @shift_count == 4
      @shift_count = 0
      letter_encrypted = @alphabet.rotate(letter_index + @shift_hash[:D])[0]
    end
    letter_encrypted
  end

  def decrypted_letter(letter)
    @shift_count += 1
    letter_index = @alphabet.index(letter)
    if @shift_count == 1
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:A])[0]
    elsif @shift_count == 2
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:B])[0]
    elsif @shift_count == 3
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:C])[0]
    elsif @shift_count == 4
      @shift_count = 0
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:D])[0]
    end
    letter_decrypted
  end

end
