module ShiftGenerator
    def key_generator
      numbers = (0..9).to_a
      @random_key = numbers.sample(5).join
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
      key_array = split_key(key)
      @shift_hash[:A] = key_array[0] + offset_array[0].to_i
      @shift_hash[:B] = key_array[1] + offset_array[1].to_i
      @shift_hash[:C] = key_array[2] + offset_array[2].to_i
      @shift_hash[:D] = key_array[3] + offset_array[3].to_i
      @shift_hash
    end
end
