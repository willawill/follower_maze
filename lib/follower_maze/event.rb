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
  end
end
