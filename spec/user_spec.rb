require "spec_helper"

describe FollowerMaze::User do
  let(:id) { 5 }
  let(:conn) { {} }
  subject { described_class.new(id, conn) }

  describe "#initialize" do
    it "creates a new user" do
      expect(subject.id).to eq(5)
      expect(subject.conn).to eq({})
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
end
