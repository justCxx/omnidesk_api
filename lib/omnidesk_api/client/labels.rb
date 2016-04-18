module OmnideskApi
  class Client
    module Labels
      def labels(options = {})
        get 'labels.json', options
      end
    end
  end
end
