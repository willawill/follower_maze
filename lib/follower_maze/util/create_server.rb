module FollowerMaze
  module Util
    module CreateServer
      attr_reader :host, :port

      def server
        @conn ||= TCPServer.new(@port)
      end

      def close
        @conn.close
      end
    end
  end
end
