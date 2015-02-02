module FollowerMaze
  class EventsListener
    def initialize
      @server = TCPServer.new(FollowerMaze::EVENT_PORT)
      @handler = EventHandler.new
    end

    def start
      $logger.info("Event listner is connected.")
      @handler.start
      loop do
        conn = @server.accept

        until conn.eof?
          event_payload = conn.readline.strip
          event = Event.new(event_payload)
          @handler.add_event(event)
        end
      end
    end

    def kill
      @server.close
    end
  end
end
