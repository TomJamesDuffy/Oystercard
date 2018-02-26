require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  describe '#initialization' do # where the code being tested comes from
    it 'should initialize with a balance of zero' do # what it should do
      expect(subject.balance).to eq 0 # expectation
    end
  end
end
