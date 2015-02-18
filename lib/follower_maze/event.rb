module FollowerMaze
  class Event
    attr_reader :id, :from, :event_type, :to, :pay_load

    def self.create_event(pay_load)
      id, event_type, from, to = pay_load.split("|")
      klass = concrete_event(event_type)
      klass.new(id, event_type, from, to, pay_load)
    end

    def self.concrete_event(event_type)
      case event_type
      when "F"
        FollowEvent
      when "U"
        UnfollowEvent
      when "B"
        BroadcastEvent
      when "S"
        StatusUpdateEvent
      when "P"
        PrivateMessageEvent
      else
        InvalidEvent
      end
    end

    def initialize(id, event_type, from, to, pay_load)
      @id, @event_type, @from, @to, @pay_load = id.to_i, event_type, from, to, pay_load
    end

    private

    ["to", "from"].each do |name|
      define_method "#{name}_user" do
        UserPool.find_or_create_user(self.send name)
      end
    end
  end

  class FollowEvent < Event
    def execute!
      to_user.add_follower(@from)
      to_user.notify(@pay_load + "\r\n")
    end
  end

  class UnfollowEvent < Event
    def execute!
      to_user.remove_follower(@from)
    end
  end

  class BroadcastEvent < Event
    def execute!
      UserPool.connected_users.each do |_, user|
        user.notify(@pay_load)
      end
    end
  end

  class StatusUpdateEvent < Event
    def execute!
      from_user.followers.each do |user_id|
        follower = UserPool.find_or_create_user(user_id)
        follower.notify(@pay_load)
      end
    end
  end

  class PrivateMessageEvent < Event
    def execute!
      to_user.notify(@pay_load)
    end
  end

  class InvalidEvent < Event
    def execute!
      $logger.info("===========Invalid Event=============")
      $logger.info("The event #{@pay_load} is invalid")
    end
  end
end
