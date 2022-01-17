require 'date'
require_relative 'message_changer'
require_relative 'shift_generator'

class Enigma
  include MessageChanger
  include ShiftGenerator
  attr_reader :new_message, :random_key, :key,
              :date, :shift_count
              :message_to_be_encrypted

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @shift_hash = Hash.new(0)
    @shift_count = 0
    @new_message = nil
    @key = nil
    @random_key = nil
    @date = nil
    @message_to_be_encrypted = true
  end

  def encrypt(message, key =key_generator, date =Date.today.strftime("%d%m%y"))
    @key = key
    @date = date
    @encrypted = {
      encryption: message_generator(message, key, date),
      key: key,
      date: date
    }
  end

  def decrypt(message, key, date =Date.today.strftime("%d%m%y"))
    @key = key
    @date = date
    @message_to_be_encrypted = false
    {
      decryption: message_generator(message, key, date),
      key: key,
      date: date
    }
  end
end
