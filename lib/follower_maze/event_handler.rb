module FollowerMaze
  class EventHandler
    @@events_buffer = EventBuffer.new

    class << self
      def add_event(event)
        @@events_buffer.add_event(event)

        @@events_buffer.ready_events do |event|
          $logger.debug "Event #{event.pay_load} should be executing...."
          event.execute!
        end
      end
    end
  end
end
