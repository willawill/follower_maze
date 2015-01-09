require "spec_helper"

module FollowerMaze
  describe Event do
    subject { described_class.new ("12|F|123|345") }

    describe "#initialize" do
      it "creates event with event payload" do
        expect(subject.id).to eq("12")
        expect(subject.event_type).to eq("F")
        expect(subject.from).to eq("123")
        expect(subject.to).to eq("345")
      end
    end

    describe "#concrete_event" do
      it "creates the concrete event based on the event type" do
        expect(subject.concrete_event).to be(FollowEvent)
      end
    end

    describe "#execute!" do

    end
  end
end
