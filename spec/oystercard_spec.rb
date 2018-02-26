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
    it "should raise error if limit of #{Oystercard::DEFAULT_LIMIT} reached" do
      expect { subject.top_up(91) } .to raise_error(RuntimeError)
    end
  end

  describe '#deduct' do
    it 'should deduct from the card the value passed as an argument' do
      subject.top_up(10)
      subject.deduct(10)
      expect(subject.balance).to eq 0
    end
    it "should raise error if balance is less than or equal to 0" do
      expect { subject.deduct(10) } .to raise_error(RuntimeError)
    end
  end
end
