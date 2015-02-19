module FollowerMaze
  class Server
    def initialize(client_config, event_config)
      @listeners = [ClientListener.new(client_config), EventsListener.new(event_config)]
    end

    def start
      trap(:INT) { shut_down }

      @listeners.map do |listener|
        Thread.new do
          listener.start
        end
      end.each(&:join)
    end

    def shut_down
      begin
        @listeners.each { |l| l.kill }
      rescue
        p "Bye"
      end
    end
  end
end
