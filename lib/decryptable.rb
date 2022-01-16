module Decryptable
  def decryptor(message, key, date)
    offset = date_to_offset(date)
    final_shift(key, offset)
    message_array = message.downcase.chars
    @decrypted_message = decrypt_character_filter(message_array)
  end

  def decrypt_character_filter(message_array)
    decrypted_message_array = []
    message_array.each { |letter|
      if letter == " "
        if @shift_count == 4
          @shift_count = 0
        else
          @shift_count += 1
        end
        decrypted_message_array << letter
      elsif @alphabet.include?(letter)
        decrypted_message_array << decrypted_letter(letter)
      else
        if @shift_count == 4
          @shift_count = 0
        else
          @shift_count += 1
        end
        decrypted_message_array << letter
      end }
      decrypted_message_array.join
  end

  def decrypted_letter(letter)
    @shift_count += 1
    if @shift_count == 1
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:A])[0]
    elsif @shift_count == 2
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:B])[0]
    elsif @shift_count == 3
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:C])[0]
    elsif @shift_count == 4
      @shift_count = 0
      letter_index = @alphabet.index(letter)
      letter_decrypted = @alphabet.rotate(letter_index - @shift_hash[:D])[0]
    end
    letter_decrypted
  end

  def decrypt(message, key, date =Date.today.strftime("%d%m%y"))
    @key = key
    @date = date
    {
      decryption: decryptor(message, key, date),
      key: key,
      date: date
    }
  end
end
