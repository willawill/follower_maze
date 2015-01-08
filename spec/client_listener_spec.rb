require "spec_helper"

describe FollowerMaze::ClientListener do
  subject { described_class.new }

  before(:each) do
    allow(TCPServer).to receive(:new)
  end

  describe "#initialize" do
    it "creates a TCPServer instance" do
      expect(TCPServer).to receive(:new).with(9099)
      subject
    end
  end
end
