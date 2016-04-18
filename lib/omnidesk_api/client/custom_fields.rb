module OmnideskApi
  class Client
    module CustomFields
      def custom_fields(options = {})
        get 'custom_fields.json', options
      end
    end
  end
end
