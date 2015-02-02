require "spec_helper"

describe FollowerMaze::User do
  let(:id) { 5 }
  let(:conn) { nil }
  subject { described_class.new(id, conn) }

  describe "#initialize" do
    it "creates a new user" do
      expect(subject.id).to eq(5)
      expect(subject.conn).to eq(nil)
    end
  end

  describe "#add_follower" do
    it "adds the follower's id to the user's followers array" do
      subject.add_follower("new user")
      expect(subject.followers).to eq(["new user"])
    end
  end

  describe "#remove_follower" do
    it "removes the follower's id from the user's followers array" do
      subject.add_follower("follower")
      subject.remove_follower("follower")

      expect(subject.followers).to eq([])
    end
  end

  describe "#notify" do
    context "when the current user is connected" do
      let(:connection) { double(puts: "foo") }

      it "sends message to the recipient" do
        subject.conn = connection
        expect(subject.conn).to receive(:puts).with("345")

        subject.notify("345")
      end
    end

    context "when the user is disconnected" do
      it "fails silently" do
        expect(subject.conn).not_to receive(:puts)

        subject.notify("345")
      end
    end
  end
end
