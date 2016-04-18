module OmnideskApi
  class Client
    module Users
      def users(options = {})
        get 'users.json', options
      end

      def user(user_id, options = {})
        get "users/#{user_id}.json", options
      end
    end
  end
end
