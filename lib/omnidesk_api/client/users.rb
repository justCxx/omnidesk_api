module OmnideskApi
  class Client
    module Users
      def users(options = {})
        get 'users.json', options
      end

      def user(user_id, options = {})
        get "users/#{user_id}.json", options
      end

      def create_user(options = {})
        post 'users.json', options
      end

      def update_user(user_id, options = {})
        put "users/#{user_id}.json", options
      end

      def disable_user(user_id, options = {})
        put "users/#{user_id}/disable.json", options
      end

      def block_user(user_id, options = {})
        put "users/#{user_id}/block.json", options
      end

      def restore_user(user_id, options = {})
        put "users/#{user_id}/restore.json", options
      end

      def delete_user(user_id, options = {})
        delete "users/#{user_id}.json", options
      end
    end
  end
end
