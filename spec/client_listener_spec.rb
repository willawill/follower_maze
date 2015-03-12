require "spec_helper"
module FollowerMaze
  describe ClientListener do
    let(:config) { double(host: "foo", port: "bar") }

    describe "#initialize" do
      it "creates a new ClientListener with host and port" do
        expect(TCPServer).to receive(:new).with("foo", "bar")
        described_class.new(config)
      end
    end
  end
end