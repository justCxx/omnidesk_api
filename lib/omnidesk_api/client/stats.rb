module OmnideskApi
  class Client
    module Stats
      def stats_lb_staff(options = {})
        get 'stats_lb_staff.json', options
      end

      def stats_lb_groups(options = {})
        get 'stats_lb_groups.json', options
      end
    end
  end
end
