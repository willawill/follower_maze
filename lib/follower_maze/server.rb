module FollowerMaze
  class Server
    attr_reader :listeners

    def initialize
      @listeners = [ClientListener.new, EventsListener.new]
    end

    def start
      @listeners.map do |listener|
       Thread.new { listener.start }
     end.each(&:join)
    end
  end
end
