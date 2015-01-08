module FollowerMaze
  class ClientListener
    def initialize
      @port = 9099

      @server = TCPServer.new(@port)
    end

    def start
      loop do
        conn = @server.accept

        user_id = conn.readline.strip
        User.new(user_id, conn)
      end
    end
  end
end
