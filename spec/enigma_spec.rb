require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  subject { Enigma.new }

    it "exists" do
      expect(subject).to be_a Enigma
    end

  context "Finding the Shifts" do

    it "should generate random five digit number" do
      expect(subject.key_generator.size).to eq(5)
    end

    it "splits random five digit number" do
      expect(subject.split_key("02715")).to eq([02,27,71,15])
    end

    it "changes date to offset" do
      expect(subject.date_to_offset("040895")).to eq("1025")
    end
  end

  context "Encrypting a message" do

    it "creates final shift" do
      key = [02,27,71,15]
      offset = "1025"
      final_shift = {
        A: 3,
        B: 27,
        C: 73,
        D: 20
      }
      expect(subject.final_shift(key, offset)).to eq(final_shift)
    end

    it "encrypts a message with a key and date" do
      subject.final_shift([02,27,71,15], "1025")
      expect(subject.encryptor("hello world", "02715", "040895")).to eq("keder ohulw")
    end

    it "encrypts a message that includes characters or capitalized" do
      subject.final_shift([02,27,71,15], "1025")
      expect(subject.encryptor("HELLO, world!", "02715", "040895")).to eq("keder, prrdx!")
    end
  end
end
