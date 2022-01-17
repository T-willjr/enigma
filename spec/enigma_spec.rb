require_relative 'spec_helper'
require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  subject { Enigma.new }

    it "exists" do
      expect(subject).to be_a Enigma
      expect(subject.shift_count).to eq(0)
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

  context "Encrypting a message" do

    it "encrypts a message with a key and date" do
      subject.encrypt("hello world", "02715", "040895")
      expect(subject.new_message).to eq("keder ohulw")
    end

      it "encrypts a message that includes characters or capitalized" do
      subject.encrypt("hello, world!", "02715", "040895")
      expect(subject.new_message).to eq("keder, prrdx!")
    end

    it "encrypts a message with todays date" do
      expect(subject.encrypt("hello world", "02715")).to eq(
      {
       encryption: subject.new_message,
       key: "02715",
       date: Date.today.strftime("%d%m%y")
      })
    end

    it "encrypts a message with todays date and random key" do
      expect(subject.encrypt("hello world")).to eq(
      {
       encryption: subject.new_message,
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
        subject.decrypt("keder ohulw", "02715", "040895")
        expect(subject.new_message).to eq("hello world")
      end

      it "decrypts a message that includes characters or capitalized" do
        subject.decrypt("KEDER, prrdx!$%^", "02715", "040895")
        expect(subject.new_message).to eq("hello, world!$%^")
      end

      it "returns decrypted information in hash" do
        expected =  {
         decryption: "hello world",
         key: "02715",
         date: "040895"
        }
        expect(subject.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
      end

      it "decrypts a message with todays date" do
        subject.encrypt("hello world", "02715")
        expect(subject.decrypt(subject.new_message, "02715")).to eq(
        {
         decryption: subject.new_message,
         key: "02715",
         date: Date.today.strftime("%d%m%y")
        })
      end
    end
  end
end
