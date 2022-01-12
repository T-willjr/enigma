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
end
