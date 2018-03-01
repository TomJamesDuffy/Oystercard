require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  let(:dummy_station) { double :dummy_station, 
                        empty?: nil }

  let(:dummy_journey) { double :dummy_journey, 
                        entry_station: "", 
                        exit_station: "", 
                        add_entry: dummy_station, 
                        add_exit: dummy_station, 
                        fee: 1, 
                        state: [], 
                        manual_end: ["", nil] }

  let(:dummy_journey_fine) { double :dummy_journey, 
                        entry_station: "", 
                        exit_station: "", 
                        add_entry: dummy_station, 
                        add_exit: dummy_station, 
                        fee: 6, 
                        state: [], 
                        manual_end: ["", nil] }

  describe '#initialization' do 
    it 'should initialize with a balance of zero' do
      expect(subject.balance).to eq 0 
    end
    it 'history should initialize empty' do
      expect(subject.history.length).to eq(0)
    end
    it 'use should initialize set to :out' do
      expect(subject.use).to eq(:out)
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

  describe '#touch_in' do
    before (:each) do
      subject.top_up(50)
    end
    after (:each) do
      subject.touch_in(dummy_station)
    end 
    context "journey is ongoing" do
      it "calls fine method" do
        subject.instance_variable_set(:@use, :in)
        expect(subject).to receive(:fine_protocol).with(dummy_station)
      end
    end
    context "journey is not ongoing" do
      it "calls new journey method" do
        expect(subject).to receive(:new_journey).with(dummy_station)
      end
    end
  end

  describe "#new_journey" do
    it "should raise an error if the user has less than 1 for journey" do
      expect { subject.touch_in(dummy_station) }.to raise_error(RuntimeError)
    end
    it "should set use to in" do
      subject.top_up(50)
      subject.new_journey(dummy_station, dummy_journey)
      expect(subject.use).to eq(:in)
    end
  end

  describe "#restart_journey" do
    it "should set use to out" do
      subject.top_up(50)
      subject.restart_journey
      expect(subject.use).to eq(:out)
    end
  end

  describe "#fine_protocol" do
    it "log should return an array" do
      subject.top_up(50)
      subject.new_journey(dummy_station, dummy_journey)
      subject.fine_protocol(dummy_station)
      expect(subject.history).to eq([["", nil]])
    end 
    it "should raise an error if user can't pay the fine" do
      subject.top_up(10)
      subject.new_journey(dummy_station, dummy_journey_fine)
      subject.instance_variable_set(:@balance, 1)
      expect { subject.fine_protocol(dummy_station) }.to raise_error(RuntimeError)
    end
    it "should reduce balance by fine if they can pay it" do
      subject.top_up(50)
      subject.new_journey(dummy_station, dummy_journey)
      expect{subject.fine_protocol(dummy_station)}.to change{subject.balance}.by(-dummy_journey.fee)
    end
    it "should push journey into history" do
      subject.top_up(50)
      subject.new_journey(dummy_station, dummy_journey)
      subject.fine_protocol(dummy_station)
      expect(subject.history[0]).to_not be_empty
    end
    it "it should call the method restart_journey" do
      subject.top_up(50)
      subject.new_journey(dummy_station, dummy_journey)
      expect(subject).to receive(:restart_journey)
      subject.fine_protocol(dummy_station)
    end
  end

  describe '#touch_out' do
    before (:each) do
      subject.top_up(10)
    end
    it "should record the entry and exit station" do
      subject.new_journey(dummy_station, dummy_journey)
      expect(subject).to receive(:record_history).with(["", nil])
      subject.fine_protocol(dummy_station)
    end 
    it "should raise error if not touched in" do
      subject.new_journey(dummy_station, dummy_journey)
      expect { subject.touch_out(dummy_station)}.to raise_error(RuntimeError)
    end
    it "should set use to out" do
      subject.touch_in(dummy_station)
      subject.touch_out(dummy_station)
      expect(subject.use).to eq :out
    end
    it "should deduct balance by 1" do
      subject.touch_in(dummy_station)
      expect { subject.touch_out(dummy_station) } .to change { subject.balance } .by(-dummy_journey.fee)
    end
    it 'history should have 1 item' do
      subject.touch_in(dummy_station)
      subject.touch_out(dummy_station)
      expect(subject.history.length).to eq(1)
    end
    it "should raise error if already touched out" do
      subject.touch_in(dummy_station)
      subject.touch_out(dummy_station)
      expect { subject.touch_out(dummy_station) } .to raise_error(RuntimeError)
    end
  end

  describe "#journey_ongoing" do
    it "should return true when use is equal to :in" do
      subject.instance_variable_set(:@use, :in)
      expect(subject.journey_ongoing?).to eq(true)
    end
  end
end
