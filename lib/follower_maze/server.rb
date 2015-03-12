module FollowerMaze
  class Server
    def initialize(client_config, event_config)
      @listeners = [ClientListener.new(client_config), EventsListener.new(event_config)]
      $logger.info "ClientListener is connected at #{client_config.host}:#{client_config.port}"
      $logger.info "ClientListener is connected at #{event_config.host}:#{event_config.port}"
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
      @listeners.each do |l|
        begin
          l.kill
        rescue IOError
        end
      end
      puts "Bye!"
    end
  end
end
