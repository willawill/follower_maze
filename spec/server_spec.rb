require "spec_helper"
module FollowerMaze
  describe FollowerMaze::Server do
    subject { described_class.new(1000, 2000) }

    let(:client_double) { instance_double(ClientListener, start: "foo") }
    let(:events_double) { instance_double(EventsListener, start: "bar") }

    before(:each) do
      allow(ClientListener).to receive(:new).and_return(client_double)
      allow(EventsListener).to receive(:new).and_return(events_double)
    end

    describe "#initialize" do
      it "creates two listeners" do
        expect(subject.listeners.count).to eq(2)
      end
    end

    describe "#start" do
      it "starts listening to the connected server" do
        expect(client_double).to receive(:start)
        expect(events_double).to receive(:start)
        subject.start
      end
    end
  end
end
