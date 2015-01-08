module FollowerMaze
  class EventsListener
    def initialize
      @port = 9090

      @server = TCPServer.new(@port)
    end

    def start
      loop do
        conn = @server.accept
        event_payload = conn.readline.strip
        event = Event.new(event_payload)
        event.execute!
      end
    end
  end
end
