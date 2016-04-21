module OmnideskApi
  class Client
    module Cases
      def cases(options = {})
        get 'cases.json', options
      end

      def case(case_id, options = {})
        get "cases/#{case_id}.json", options
      end

      def create_case(options = {})
        post 'cases.json', options
      end

      def update_case(case_id, options = {})
        put "cases/#{case_id}.json", options
      end

      def trash_case(case_id, options = {})
        put "cases/#{case_id}/trash.json", options
      end

      def spam_case(case_id, options = {})
        put "cases/#{case_id}/spam.json", options
      end

      def restore_case(case_id, options = {})
        put "cases/#{case_id}/restore.json", options
      end

      def delete_case(case_id, options = {})
        delete "cases/#{case_id}.json", options
      end

      def messages(case_id, options = {})
        get "cases/#{case_id}/messages.json", options
      end

      def create_message(case_id, options = {})
        post "cases/#{case_id}/messages.json", options
      end

      def create_note(case_id, options = {})
        post "cases/#{case_id}/notes.json", options
      end
    end
  end
end
