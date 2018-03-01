require 'journey'

describe Journey do
  subject(:journey) { Journey.new }
  let(:dummy_station) { double :dummy_station }

  describe "#initialize" do
    it "on intitialisation entry station is created" do
      expect(journey.entry_station).to be_instance_of(String)
    end
    it "on intitialisation exit station is created" do
      expect(journey.exit_station).to be_instance_of(String)
    end
  end

  describe "#add_entry" do
    it "adds station to the entry" do
      journey.add_entry(dummy_station)
      expect(journey.entry_station).to eq(dummy_station)
    end
  end

  describe "#manual_end" do
    it "sets exit station to nil" do
      subject.manual_end
      expect(subject.exit_station).to eq(nil)
    end
    it "returns an array of entry and exit station" do
      expect(subject.manual_end).to eq(["", nil])
    end
  end

  describe "#fare" do
    it "should equal 1" do
      expect(subject.fee(:out)).to eq(1)
    end
  end

  describe "#add_exit" do
    it "adds station to the exit" do
      journey.add_exit(dummy_station)
      expect(journey.exit_station).to eq(dummy_station)
    end
  end
end
