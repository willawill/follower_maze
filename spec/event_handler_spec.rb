require "spec_helper"

module FollowerMaze
  describe EventHandler do
    subject { described_class.new }
    let(:event_double) { double(id: 123, execute!: "foo") }

    describe "#initialize" do
      it "has an event buffer as its instance variable" do
        expect(subject.instance_variable_get("@events_buffer").class).to eq(EventBuffer)
      end
    end

    describe "#add_event" do
      context "when there is a next event in the event buffer" do
        it "executes the next event" do
          subject.add_event(event_double)
          expect(event_double).not_to receive(:execute!)
        end
      end

      context "when there is no next event in the event buffer" do
        let(:next_event) { double(id: 1, execute!: "foo") }

        it "waits until the next event comes" do
          expect(next_event).to receive(:execute!)
          subject.add_event(next_event)
        end
      end
    end
  end
end