module FollowerMaze
  class EventHandler
    @@events_buffer = EventBuffer.new

    class << self
      def add_event(event)
        @@events_buffer.add_event(event)
        while @@events_buffer.has_next?
          event = @@events_buffer.get_next
          event.execute!
        end
      end
    end
  end
end
