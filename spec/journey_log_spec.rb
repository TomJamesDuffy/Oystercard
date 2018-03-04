require 'journey_log'

describe JourneyLog do
  subject(:log) { JourneyLog.new }
  let(:dummy_journey) {double :dummy_journey, empty?: false}
  let(:dummy_station) {double :dummy_station}

  describe "#start" do
    it "start journey should assign a journey and station object" do
      expect(subject.start(dummy_station, dummy_journey)).to eq([dummy_station, dummy_journey])
    end
  end

  describe "#end" do
    it "should enter into the log" do
      expect(subject.end(dummy_station)).to eq([["", dummy_station]])
    end
  end

  describe "#journeys" do
    it "array should contain journeys" do
      subject.start(dummy_station, dummy_journey)
      subject.end(dummy_station) 
      expect(subject.journeys).to eq ([dummy_station, ""])
    end
  end
end

