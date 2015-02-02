module FollowerMaze
  class Server
    attr_reader :listeners

    def initialize
      @listeners = [ClientListener.new, EventsListener.new]
    end

    def start
      $logger.info("===========Server two starts=============")
      @listeners.map do |listener|
        Thread.new do
          listener.start
        end
     end.each(&:join)
    end
  end
end
