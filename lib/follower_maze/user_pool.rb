module FollowerMaze
  class UserPool
    @@connected_users = {}

    class << self
      def all_users
        @@connected_users
      end

      def connected_users
        @@connected_users.select {|user| !user.conn.blank? }
      end

      def add_or_update_user(user_id, conn)
        user = find_or_create_user(user_id)
        user.conn = conn
        @@connected_users[user.id] = user
      end

      def remove_user(user_id)
        @@connected_users.delete(user_id)
      end

      def find_or_create_user(user_id)
        @@connected_users[user_id] || User.new(user_id, nil)
      end
    end
  end
end
