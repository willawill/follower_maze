module FollowerMaze
  class Event
    attr_reader :id, :event_type, :from, :to

    def initialize(pay_load)
      @id, @event_type, @from, @to = pay_load.split("|")
    end

    def execute!
      case @event_type
      when "F"
        "follow"
      when "U"
        "unfollow"
      when "B"
        "broadcast"
      when "S"
        "status update"
      when "P"
        "private message"
      else
        "fail silently"
      end
    end
  end
end
