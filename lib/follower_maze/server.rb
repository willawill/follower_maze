module FollowerMaze
  class Server
    attr_reader :listeners
    def initialize
      @users = []
      @listeners = [EventsListener.new, ClientListener.new]
    end

    def start
      @listeners.each { |l| l.start }
    end
  end
end
