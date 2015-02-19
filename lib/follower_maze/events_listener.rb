module FollowerMaze
  class EventsListener
    def initialize(config)
      @server = TCPServer.new(config.host, config.port)
      @handler = EventHandler.new
    end

    def start
      $logger.info("Event listner is connected.")
      conn = @server.accept

      while line = conn.gets do
        event_payload = line.strip
        event = Event.create_event(event_payload)
        @handler.add_event(event)
      end
    end

    def kill
      @server.close
    end
  end
end
