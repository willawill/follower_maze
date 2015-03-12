require "spec_helper"

module FollowerMaze
  describe EventBuffer do
    let(:event_double) { double(id: 1)}

    describe "#initialize" do
      it "initalizes an EventBuffer" do
        expect(subject.instance_variable_get("@events")).to eq({})
        expect(subject.instance_variable_get("@next_event")).to eq(1)
      end
    end

    describe "#add_event" do
      it "adds the event to the event buffer" do
        subject.add_event(event_double)
        expect(subject.instance_variable_get("@events")).to eq( { 1 => event_double } )
      end
    end

    describe "#get_next" do
      before(:each) do
        subject.add_event(event_double)
      end

      it "returns the event with next event ID" do
        expect { |b| subject.ready_events &b }.to yield_with_args(event_double)
      end

      it "removes the event with next event ID from the event buffer" do
        subject.ready_events {}
        expect(subject.instance_variable_get("@events")).to eq({})
      end

      it "increases the next_event ID by 1" do
        subject.ready_events {}
        expect(subject.instance_variable_get("@next_event")).to eq(2)
      end
    end
  end
end
