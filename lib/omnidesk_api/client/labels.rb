module OmnideskApi
  class Client
    module Labels
      def labels(options = {})
        get 'labels.json', options
      end

      def create_label(options = {})
        post 'labels.json', options
      end

      def update_label(label_id, options = {})
        put "labels/#{label_id}.json", options
      end

      def delete_label(label_id, options = {})
        delete "labels/#{label_id}.json", options
      end
    end
  end
end
