module FollowerMaze
  class ClientListener
    include Util::CreateServer

    def initialize
      @port = 9099
      @server = TCPServer.new(@port)
    end

    def start
      loop do
        conn = @server.accept
        user_id = conn.readline.strip
        UserPool.add_or_update_user(new_user, conn)
      end
    end

    def kill
      @server.close
    end
  end
end
