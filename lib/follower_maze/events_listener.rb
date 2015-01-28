module FollowerMaze
  class EventsListener
    def initialize
      @port = 9090
      @server = TCPServer.new(@port)
      @handler = EventHandler.new
    end

    def start
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
