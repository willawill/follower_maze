module FollowerMaze
  class Server
    attr_reader :listeners

    def initialize(client_port, event_port)
      @listeners = [ClientListener.new(client_port), EventsListener.new(event_port)]
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
