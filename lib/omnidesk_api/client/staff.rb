module OmnideskApi
  class Client
    module Staff
      def staff_all(options = {})
        get 'staff.json', options
      end

      def staff(staff_id, options = {})
        get "staff/#{staff_id}.json", options
      end

      def create_staff(options = {})
        post 'staff.json', options
      end

      def update_staff(staff_id, options = {})
        put "staff/#{staff_id}.json", options
      end

      def enable_staff(staff_id, options = {})
        put "staff/#{staff_id}/enable.json", options
      end

      def disable_staff(staff_id, options = {})
        put "staff/#{staff_id}/disable.json", options
      end

      def delete_staff(staff_id, options = {})
        delete "staff/#{staff_id}.json", options
      end
    end
  end
end
