module FollowerMaze
  describe UserPool do
    subject { described_class }
    let(:user) { User.new("id", nil) }
    let(:connection) { double(puts: "message") }

    after { subject.all_users = {} }

    describe ".all_users" do
      it "returns all users" do
        subject.all_users = {}

        expect(subject.all_users).to eq({})
      end
    end

    describe ".connected_users" do
      it "returns all the currently connected user" do
        subject.all_users = { "connected" => instance_double(User, conn: "connected"),
                              "disconnected" => instance_double(User, conn: nil) }

        expect(subject.connected_users.count).to eq(1)
      end
    end

    describe ".add_or_update_user" do
      it "updates the user with current connection situation" do
        allow(subject).to receive(:find_or_create_user).and_return(user)
        subject.add_or_update_user("id", connection)

        expect(user.conn).to eq(connection)
      end
    end

    describe ".remove_user" do
      it "removes the id: user_instance pair from UserPool" do
        subject.all_users = { "id" => user }

        subject.remove_user(user.id)
        expect(subject.all_users).to eq({})
      end
    end

    describe ".find_or_create_user" do
      it "finds user_instance from UserPool with user id" do
        user = subject.find_or_create_user("id")

        expect(user).to eq(user)
      end
    end
  end
end
