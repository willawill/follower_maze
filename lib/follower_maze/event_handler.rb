module FollowerMaze
  class EventHandler
    def initialize
      @events_buffer = EventBuffer.new
    end

    def add_event(event)
      @events_buffer.add_event(event)
      while @events_buffer.has_next?
        event = @events_buffer.get_next
        event.execute!
      end
    end
  end
end
