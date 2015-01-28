module FollowerMaze
  class Event
    attr_reader :id, :event_type, :from, :to, :pay_load

    def initialize(pay_load)
      @pay_load = pay_load
      @id, @event_type, @from, @to = pay_load.split("|")
    end

    def concrete_event
      case @event_type
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

    def execute!
      concrete_event.new(@pay_load).execute!
    end
  end

  class FollowEvent < Event
    def execute!
      to_user = UserPool.find_or_create_user(@to)
      to_user.add_follower(@from)
      to_user.notify(@pay_load + "\r\n")
    end
  end

  class UnfollowEvent < Event
    def execute!

      to_user = UserPool.find_or_create_user(@to)
      to_user.remove_follower(@from)
    end
  end

  class BroadcastEvent < Event
    def execute!

      UserPool.connected_users.each do |id, user|
        user.notify(@pay_load)
      end
    end
  end

  class StatusUpdateEvent < Event
    def execute!
      from_user = UserPool.find_or_create_user(@from)
      from_user.followers.each do |user_id|
        follower = UserPool.find_or_create_user(user_id)
        follower.notify(@pay_load)
      end
    end
  end

  class PrivateMessageEvent < Event
    def execute!
      to_user = UserPool.find_or_create_user(@to)
      to_user.notify(@pay_load)
    end
  end
end
