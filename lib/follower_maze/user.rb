module FollowerMaze
  class User
    attr_reader :id, :followers
    attr_accessor :conn

    def initialize(id, conn=nil)
      @id = id
      @conn = conn
      @followers = []
    end

    def add_follower(follower_id)
      @followers << follower_id
    end

    def remove_follower(follower_id)
      @followers.delete(follower_id)
    end

    def notify(message)
      @conn.puts message unless @conn == nil
    end
  end
end
