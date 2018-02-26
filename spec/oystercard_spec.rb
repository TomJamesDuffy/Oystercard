require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  describe '#initialization' do # where the code being tested comes from
    it 'should initialize with a balance of zero' do # what it should do
      expect(subject.balance).to eq 0 # expectation
    end
  end
  describe '#top_up' do
    it 'should top up the card with the value passed as an argument' do
      subject.top_up(10)
      expect(subject.balance).to eq 10  
    end
  end
end
