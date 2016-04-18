module OmnideskApi
  class Client
    module Staff
      def staffs(options = {})
        get 'staff.json', options
      end

      def staff(staff_id, options = {})
        get "staff/#{staff_id}.json", options
      end
    end
  end
end
