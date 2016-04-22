require 'omnidesk_api/response/raise_error'
require 'faraday_middleware'

module OmnideskApi
  module Default
    # Default User Agent header string
    USER_AGENT = "OmnideskApi Ruby Gem #{OmnideskApi::VERSION}".freeze

    # Default media type
    MEDIA_TYPE = 'application/json'.freeze

    # Default Faraday middleware stack
    MIDDLEWARE = Faraday::RackBuilder.new do |builder|
      builder.use OmnideskApi::Response::RaiseError
    end

    # Default page size
    PER_PAGE = 100

    class << self
      # Configuration options
      # @return [Hash]
      def options
        Hash[OmnideskApi::Configurable.keys.map { |key| [key, send(key)] }]
      end

      # Default API endpoint from ENV
      # @return [String]
      def api_endpoint
        ENV['OMNIDESK_API_ENDPOINT']
      end

      # Default Omnidesk username for Basic Auth from ENV
      # @return [String]
      def login
        ENV['OMNIDESK_API_LOGIN']
      end

      # Default Omnidesk password for Basic Auth from ENV
      # @return [String]
      def password
        ENV['OMNIDESK_API_PASSWORD']
      end

      # Default pagination page size from ENV
      # @return [Fixnum] Page size
      def per_page
        page_size = ENV['OMNIDESK_API_PER_PAGE']
        page_size ? page_size.to_i : PER_PAGE
      end

      # Default media type from ENV or {MEDIA_TYPE}
      # @return [String]
      def default_media_type
        ENV['OMNIDESK_API_DEFAULT_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # Default User-Agent header string from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV['OMNIDESK_API_USER_AGENT'] || USER_AGENT
      end

      # Default middleware stack for Faraday::Connection
      # from {MIDDLEWARE}
      # @return [Faraday::RackBuilder]
      def middleware
        MIDDLEWARE
      end

      # Default proxy server URI for Faraday connection from ENV
      # @return [String]
      def proxy
        ENV['OMNIDESK_API_PROXY']
      end

      # Default options for Faraday::Connection
      # @return [Hash]
      def connection_options
        {
          headers: {
            accept: default_media_type,
            user_agent: user_agent
          }
        }
      end
    end
  end
end
