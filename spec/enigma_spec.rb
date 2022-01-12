require 'date'
require './lib/enigma'


RSpec.describe Enigma do
  subject { Enigma.new }

  it "exists" do
    expect(subject).to be_a Enigma
  end
end  
