require "spec_helper"
module FollowerMaze
  describe FollowerMaze::Server do
    let(:client_config) { double() }
    let(:event_config) { double() }

    subject { described_class.new(client_config, event_config) }

    let(:client_double) { instance_double(ClientListener, start: "foo") }
    let(:events_double) { instance_double(EventsListener, start: "bar") }

    before(:each) do
      allow(ClientListener).to receive(:new).with(client_config).and_return(client_double)
      allow(EventsListener).to receive(:new).with(event_config).and_return(events_double)
    end

    describe "#initialize" do
      it "creates ClientListener and EventsListener" do
        expect(ClientListener).to receive(:new).with(client_config)
        expect(EventsListener).to receive(:new).with(event_config)
        subject
      end

      it "creates two listeners" do
        expect(subject.instance_variable_get("@listeners").count).to eq(2)
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
