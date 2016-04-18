module OmnideskApi
  class Client
    module Groups
      def groups(options = {})
        get 'groups.json', options
      end

      def group(group_id, options = {})
        get "groups/#{group_id}", options
      end
    end
  end
end
