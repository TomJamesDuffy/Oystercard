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

  describe '#touch_in' do
    it "should set use to in" do
      subject.top_up(10)
      subject.touch_in
      expect(subject.use).to eq :in
    end
    it "should raise an error if your find are less than #{Oystercard::FARE} for journey" do
      expect { subject.touch_in } .to raise_error(RuntimeError)
    end
  end

  describe '#touch_out' do
    it "should raise error if not touched in" do
      expect { subject.touch_out } .to raise_error(RuntimeError)
    end
    it "should set use to out" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.use).to eq :out
    end
  end


  describe '#in_journey?' do
    before(:each) do
      subject.top_up(10)
      subject.touch_in  
    end

    it "in journey should respond with true" do
      expect(subject.in_journey?).to eq true
    end
    it "in journey should respond with false" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end 
end

