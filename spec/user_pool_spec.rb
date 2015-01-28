require "spec_helper"

module FollowerMaze
  describe UserPool do
    subject { UserPool }
    let(:user_double) { instance_double(User, id: "id") }

    describe ".all_users" do
      it "returns all connected users" do
        expect(subject.all_users).to eq({})
      end
    end

    describe ".add_or_update_user" do
      it "adds new id : user_instance pair to UserPool" do
        subject.add_or_update_user(user_double)
        expect(subject.all_users).to eq({"id" => user_double})
      end
    end

    describe ".remove_user" do
      it "removes the id: user_instance pair from UserPool" do
        subject.add_user(user_double)

        subject.remove_user(user_double.id)
        expect(subject.all_users).to eq({})
      end
    end

    describe ".find_user" do
      it "finds user_instance from UserPool with user id" do
        subject.add_user(user_double)

        user = subject.find_user("id")
        expect(user).to eq(user_double)
      end
    end
  end
end
