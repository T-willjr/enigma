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
      key = "02715"
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

      expect(subject.encryptor("hello world", "02715", "040895")).to eq("keder ohulw")
    end

    it "encrypts a message that includes characters or capitalized" do

      expect(subject.encryptor("HELLO, world!", "02715", "040895")).to eq("keder, prrdx!")
    end

    it "encrypts a message with todays date" do

      expect(subject.encrypt("hello world", "02715")).to eq({
       encryption: subject.encrypted_message,
       key: "02715",
       date: Date.today.strftime("%d%m%y")
      })
    end

    it "encrypts a message with todays date and random key" do

      expect(subject.encrypt("hello world")).to eq({
       encryption: subject.encrypted_message,
       key: subject.random_key,
       date: Date.today.strftime("%d%m%y")
      })
    end

    it "returns encrypted information in hash" do
      expected =  {
       encryption: "keder ohulw",
       key: "02715",
       date: "040895"
      }

      expect(subject.encrypt("hello world", "02715", "040895")).to eq(expected)
    end

    context "Decrpyting a message" do

      it "decrypts a message with a key and date" do
        expect(subject.decryptor("keder ohulw", "02715", "040895")).to eq("hello world")
      end
    end
  end
end
