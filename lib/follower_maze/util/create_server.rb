module FollowerMaze
  module Util
    module CreateServer
      attr_reader :host, :port

      def server
        @socket ||= TCPServer.new(port)
      end

      def close
        @socket.close
      end
    end
  end
end
