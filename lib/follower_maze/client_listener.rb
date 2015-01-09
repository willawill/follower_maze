module FollowerMaze
  class ClientListener
    include Util::CreateServer

    def initialize
      @port = 9099
    end

    def start
      loop do
        conn = server.accept

        user_id = conn.readline.strip
        User.new(user_id, conn)
      end
    end
  end
end
