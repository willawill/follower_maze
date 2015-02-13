module FollowerMaze
  class ListenerConfig
    attr_accessor :host, :port

    def initialize(host, port)
      @host = host
      @port = port
    end
  end
end