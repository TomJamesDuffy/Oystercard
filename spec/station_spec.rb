require 'station'

describe Station do
  subject(:Station) {Station.new("zone", "new") }

  describe "#initialize" do
    it "initializes with a name on creation" do
      expect(subject.name).to eq("new")
    end
    it "initializes with a zone on creation" do
      expect(subject.zone).to eq("zone")
    end
  end
end
