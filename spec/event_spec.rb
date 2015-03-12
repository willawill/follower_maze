require "spec_helper"

module FollowerMaze
  describe Event do
    let(:follow){ described_class.create_event("12|F|123|345") }
    let(:unfollow){ described_class.create_event ("12|U|123|345") }
    let(:status_update){ described_class.create_event ("12|S|123") }
    let(:broadcast){ described_class.create_event ("12|B|123") }
    let(:private_message){ described_class.create_event ("12|P|123|345") }
    let(:invalid){ described_class.create_event ("12|123|345") }

    describe ".create_event" do
      it "creates the event based on the event type" do
        expect(Event.create_event("12|F|123|345").class).to eq(FollowEvent)
      end
    end

    describe "#initialize" do
      it "creates event with event payload" do
        expect(follow.id).to eq(12)
        expect(follow.event_type).to eq("F")
        expect(follow.from).to eq("123")
        expect(follow.to).to eq("345")
      end
    end

    context "Concrete Events" do
      let(:to_user) { instance_double(User, notify: "message", add_follower: "add_follower" ) }

      describe FollowEvent do
        describe "#execute!" do
          before(:each) do
            allow(UserPool).to receive(:find_or_create_user).with("345").and_return(to_user)
          end

          it "finds the to_user in UserPool" do
            expect(UserPool).to receive(:find_or_create_user)
            follow.execute!
          end

          context "when the user is connected" do
            it "notifies the to_user with event payload" do
              expect(to_user).to receive(:notify).with("12|F|123|345\r\n")
              follow.execute!
            end

            it "adds the from_user to to_user's follower group" do
              expect(to_user).to receive(:add_follower).with("123")
              follow.execute!
            end
          end
        end
      end

      describe UnfollowEvent do
        let(:to_user) { instance_double(User, remove_follower: "remove_follower") }

        it "removes the from_user from to_user's followers group" do
          allow(UserPool).to receive(:find_or_create_user).with("345").and_return(to_user)
          expect(to_user).to receive(:remove_follower).with("123")

          unfollow.execute!
        end
      end

      describe BroadcastEvent do
        let(:connected_user) { instance_double(User, id: "connected", conn: "connected") }
        let(:disconnected_user) { instance_double(User, id: "disconnected", conn: nil) }

        it "notifies all the connected users" do
          UserPool.all_users = { "connected" => connected_user, "disconnected" => disconnected_user }
          expect(connected_user).to receive(:notify).with(broadcast.pay_load)
          expect(disconnected_user).not_to receive(:notify).with(broadcast.pay_load)

          broadcast.execute!
        end
      end

      describe StatusUpdateEvent do
        let(:first_follower) { instance_double(User, id: "1", notify: "foo") }
        let(:second_follower) { instance_double(User, id: "2", notify: "foo") }
        let(:from_user) { instance_double(User, followers: ["1", "2"]) }

        it "informs all the followers of from_user about the new status" do
          allow(UserPool).to receive(:find_or_create_user).with("123").and_return(from_user)
          allow(UserPool).to receive(:find_or_create_user).with("1").and_return(first_follower)
          allow(UserPool).to receive(:find_or_create_user).with("2").and_return(second_follower)

          expect(first_follower).to receive(:notify).with("12|S|123")
          expect(second_follower).to receive(:notify).with("12|S|123")

          status_update.execute!
        end
      end

      describe PrivateMessageEvent do
        let(:from_user) { instance_double(User, id: "from", conn: "connected") }
        let(:to_user) { instance_double(User, id: "to", conn: "connected", notify: "foo") }

        it "sends private message from from_user to to_user" do
          allow(UserPool).to receive(:find_or_create_user).with("345").and_return(to_user)
          expect(to_user).to receive(:notify).with("12|P|123|345")

          private_message.execute!
        end
      end
    end
  end
end
