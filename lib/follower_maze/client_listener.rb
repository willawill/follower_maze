module FollowerMaze
  class ClientListener
    def initialize(config)
      @server = TCPServer.new(config.host, config.port)
    end

    def start
      $logger.info("Client server is connected.")
      loop do
        conn = @server.accept
        user_id = conn.readline.strip
        $logger.debug "Client #{user_id} is connected."

        UserPool.add_or_update_user(user_id, conn)
      end
    end

    def kill
      @server.close
    end
  end
end
