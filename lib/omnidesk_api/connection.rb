require 'faraday'
require 'omnidesk_api/authentication'

module OmnideskApi
  # Network layer for API client
  module Connection
    include OmnideskApi::Authentication

    # Header keys that can be passed in options hash to {#get},{#head}
    CONVENIENCE_HEADERS = Set.new([:accept, :content_type])
    NO_BODY = Set.new([:get, :head])

    def get(url, options = {})
      request :get, url, parse_query_and_convenience_headers(options)
    end

    def post(url, data = nil, options = {})
      request :post, url, data, options
    end

    def put(url, data = nil, options = {})
      request :put, url, data, options
    end

    def patch(url, data = nil, options = {})
      request :patch, url, data, options
    end

    def delete(url, data = nil, options = {})
      request :delete, url, data, options
    end

    def head(url, options = {})
      request :head, url, parse_query_and_convenience_headers(options)
    end

    def last_response
      @last_response if defined? @last_response
    end

    def reset_connection!
      @connection = nil
    end

    private

    def request(method, url, data = nil, options = {})
      if no_body?(method)
        options = data if options.empty?
        data = nil
      end

      @last_response = connection.send method, url do |req|
        req.body = data if data
        req.params.update options[:query] if options[:query]
        req.headers.update options[:headers] if options[:headers]
      end

      @last_response.body
    end

    def connection
      @connection ||= Faraday.new(faraday_options) do |conn|
        conn.basic_auth(@login, @password) if basic_authenticated?
        conn.url_prefix = api_endpoint
      end
    end

    def faraday_options
      connection_options.tap do |opts|
        opts[:builder] = @middleware if @middleware
        opts[:proxy] = @proxy if @proxy
      end
    end

    def no_body?(method)
      NO_BODY.include?(method)
    end

    def parse_query_and_convenience_headers(options)
      headers = options.delete(:headers) { Hash.new }
      CONVENIENCE_HEADERS.each do |h|
        headers[h] = options.delete(h) if options[h]
      end
      query = options.delete(:query)
      opts = { query: options }
      opts[:query].merge!(query) if query && query.is_a?(Hash)
      opts[:headers] = headers unless headers.empty?

      opts
    end
  end
end
