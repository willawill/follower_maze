require "spec_helper"

describe FollowerMaze::Event do
  subject { described_class.new ("12|F|123|345") }

  describe "#initialize" do
    it "creates event with event payload" do
      expect(subject.id).to eq("12")
      expect(subject.event_type).to eq("F")
      expect(subject.from).to eq("123")
      expect(subject.to).to eq("345")
    end
  end

  describe "#execute!" do
    it "creates the handler based on the event type" do
      expect(subject.execute!).to eq("follow")
    end
  end
end
