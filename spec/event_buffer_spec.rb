require "spec_helper"

module FollowerMaze
	describe EventBuffer do
		subject { described_class.new }
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

		describe "#has_next?" do
			context "when there is an event with the next event ID" do
				it "returns true" do
					subject.add_event(event_double)
					expect(subject.has_next?).to eq(true)
				end
			end

			context "when there is no event with the next event ID" do
				it "returns false" do
					expect(subject.has_next?).to eq(false)
				end
			end
		end

		describe "#get_next" do
			before(:each) do
				subject.add_event(event_double)
			end

			it "returns the event with next event ID" do
				expect(subject.get_next).to eq(event_double)
			end

			it "removes the event with next event ID from the event buffer" do
				subject.get_next
				expect(subject.instance_variable_get("@events")).to eq({})
			end

			it "increases the next_event ID by 1" do
				subject.get_next
				expect(subject.instance_variable_get("@next_event")).to eq(2)
			end
		end
	end
end
