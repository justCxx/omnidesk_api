require 'omnidesk_api/error'

module OmnideskApi
  module Middleware
    module Response
      class RaiseError < Faraday::Response::Middleware
        private

        def on_complete(response)
          error = OmnideskApi::Error.from_response(response)
          raise error if error
        end
      end
    end
  end
end
