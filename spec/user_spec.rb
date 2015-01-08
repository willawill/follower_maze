require "spec_helper"
describe FollowerMaze::User do
  let(:id) { 5 }
  subject { described_class.new(id) }

  describe "#initialize" do
    it "creates a new user" do
      expect(subject.id).to eq(5)
    end
  end
end
