module FollowerMaze
  class Event
    attr_reader :id, :from, :event_type, :to, :pay_load
    @@event_type_map = {}

    def self.register(type)
      @@event_type_map[type] = self
    end

    def self.create_event(pay_load)
      id, event_type, from, to = pay_load.split("|")
      klass = @@event_type_map[event_type]
      klass.new(id, event_type, from, to, pay_load)
    end

    def initialize(id, event_type, from, to, pay_load)
      @id, @event_type, @from, @to, @pay_load = id.to_i, event_type, from, to, pay_load
    end

    private

    def to_user
      UserPool.find_or_create_user(@to)
    end

    def from_user
      UserPool.find_or_create_user(@from)
    end
  end

  class FollowEvent < Event
    register "F"

    def execute!
      to_user.add_follower(@from)
      to_user.notify(@pay_load)
    end
  end

  class UnfollowEvent < Event
    register "U"

    def execute!
      to_user.remove_follower(@from)
    end
  end

  class BroadcastEvent < Event
    register "B"

    def execute!
      UserPool.connected_users.each do |_, user|
        user.notify(@pay_load)
      end
    end
  end

  class StatusUpdateEvent < Event
    register "S"

    def execute!
      from_user.followers.each do |user_id|
        follower = UserPool.find_or_create_user(user_id)
        follower.notify(@pay_load)
      end
    end
  end

  class PrivateMessageEvent < Event
    register "P"

    def execute!
      to_user.notify(@pay_load)
    end
  end
end
