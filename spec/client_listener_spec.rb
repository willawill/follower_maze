require "spec_helper"
module FollowerMaze
  describe ClientListener do
    let(:config) { double(host: "foo", port: "bar") }
    subject { described_class.new(config) }

    before(:each) do
      allow(TCPServer).to receive(:new)
    end

    describe "#initialize" do
      it "creates a new ClientListener with host and port" do
        expect(TCPServer).to receive(:new).with("foo", "bar")
        subject
      end
    end
  end
end