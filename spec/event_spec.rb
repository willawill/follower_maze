require "spec_helper"

module FollowerMaze
  describe Event do
    let(:follow){ described_class.new ("12|F|123|345") }
    let(:unfollow){ described_class.new ("12|U|123|345") }
    let(:status_update){ described_class.new ("12|S|123|345") }
    let(:broadcast){ described_class.new ("12|B|123|345") }
    let(:private_message){ described_class.new ("12|P|123|345") }

    describe "#initialize" do
      it "creates event with event payload" do
        expect(follow.id).to eq("12")
        expect(follow.event_type).to eq("F")
        expect(follow.from).to eq("123")
        expect(follow.to).to eq("345")
      end
    end

    describe "#concrete_event" do
      context "#FollowEvent" do
        it "creates a FollowEvent" do
          expect(follow.concrete_event).to eq(FollowEvent)
        end
      end

      context "#UnfollowEvent" do
        it "creates an UnfollowEvent" do
          expect(unfollow.concrete_event).to eq(UnfollowEvent)
        end
      end

      context "#StatusUpdateEvent" do
        it "creates a StatusUpdateEvent" do
          expect(status_update.concrete_event).to eq(StatusUpdateEvent)
        end
      end

      context "#BroadcastEvent" do
        it "creates a BroadcastEvent" do
          expect(broadcast.concrete_event).to eq(BroadcastEvent)
        end
      end

      context "#PrivateMessageEvent"do
        it "creates a PrivateMessage" do
          expect(private_message.concrete_event).to eq(PrivateMessageEvent)
        end
      end
    end

    context "Concrete Events" do
      let(:to_user) { instance_double(User, notify: "message", add_follower: "add_follower" ) }

      describe FollowEvent do
        describe "#execute!" do
          before(:each) do
            allow(UserPool).to receive(:find_user).with("345").and_return(to_user)
          end

          it "finds the to_user in UserPool" do
            expect(UserPool).to receive(:find_user)
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

      describe BroadcastEvent do
      end
    end
  end
end
