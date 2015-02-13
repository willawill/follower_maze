module FollowerMaze
  class Server
    attr_reader :listeners

    def initialize(client_config, event_config)
      @listeners = [ClientListener.new(client_config), EventsListener.new(event_config)]
    end

    def start
      @listeners.map do |listener|
        Thread.new do
          listener.start
        end
     end.each(&:join)
    end
  end
end
