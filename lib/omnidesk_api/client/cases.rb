module OmnideskApi
  class Client
    module Cases
      def cases(options = {})
        get 'cases.json', options
      end

      def case(case_id, options = {})
        get "cases/#{case_id}.json", options
      end

      def messages(case_id, options = {})
        get "cases/#{case_id}/messages.json", options
      end

      def cases_count(options = {})
        options[:limit] = 1
        cases(options)['total_count']
      end

      def messages_count(case_id, options = {})
        options[:limit] = 1
        messages(case_id, options)['total_count']
      end
    end
  end
end
