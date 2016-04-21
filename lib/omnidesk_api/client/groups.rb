module OmnideskApi
  class Client
    module Groups
      def groups(options = {})
        get 'groups.json', options
      end

      def group(group_id, options = {})
        get "groups/#{group_id}", options
      end

      def create_group(options = {})
        post 'groups.json', options
      end

      def update_group(group_id, options = {})
        put "groups/#{group_id}.json", options
      end

      def enable_group(group_id, options = {})
        put "groups/#{group_id}/enable.json", options
      end

      def disable_group(group_id, options = {})
        put "groups/#{group_id}/disable.json", options
      end

      def delete_group(group_id, options = {})
        delete "groups/#{group_id}.json", options
      end
    end
  end
end
