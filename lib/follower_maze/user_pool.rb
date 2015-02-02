module FollowerMaze
  class UserPool
    @@users = {}

    class << self
      def all_users
        @@users
      end

      def all_users=(users)
        @@users = users
      end

      def connected_users
        @@users.select { |id, user| user.conn != nil }
      end

      def add_or_update_user(user_id, conn)
        user = find_or_create_user(user_id)
        user.conn = conn
        @@users[user.id] = user
      end

      def remove_user(user_id)
        @@users.delete(user_id)
      end

      def find_or_create_user(user_id)
        @@users[user_id] || @@users[user_id] = User.new(user_id, nil)
      end
    end
  end
end
