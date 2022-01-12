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

      expect(subject.split("02715")).to eq([02,27,71,15])
    end
    
  end
end
