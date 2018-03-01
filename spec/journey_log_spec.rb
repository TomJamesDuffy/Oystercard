require 'journey_log'

describe JourneyLog do
  subject(:log) { JourneyLog.new }
  let(:dummy_journey) {double :dummy_journey, empty?: false}
  let(:dummy_station) {double :dummy_station}

  describe "#initialize" do
    it "should have an array to store individual journeys" do
      expect(subject.log).to be_instance_of(Array)
    end
  end

  describe "#start" do
    it "start journey should create a journey object" do
      subject.start(dummy_station, dummy_journey)
      expect(subject.journey).to eq (dummy_journey)
    end
    it "should create a starting station" do
      subject.start(dummy_station, dummy_journey)
      expect(subject.start_station).to eq(dummy_station)
    end
  end

  describe "#end" do
    it "should create an ending station" do
      subject.end(dummy_station)
      expect(subject.end_station).to eq(dummy_station)
    end
    it "it should record journey on ending" do
      subject.start(dummy_station, dummy_journey)
      subject.end(dummy_station)
      expect(subject.log).to eq([[dummy_station, dummy_station]])
    end
  end

  describe "#journeys" do
    it "array should contain journeys" do
      subject.start(dummy_station, dummy_journey)
      subject.end(dummy_station) 
      expect(subject.journeys).to eq ([dummy_station, dummy_station])
    end
  end
end

