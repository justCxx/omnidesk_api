require 'faraday'
require 'omnidesk_api/authentication'

module OmnideskApi
  # Network layer for API client
  module Connection
    include OmnideskApi::Authentication

    def get(url, options = {})
      request :get, url, options
    end

    def post(url, data = nil, options = {})
      request :post, url, data, options
    end

    def put(url, data = nil, options = {})
      request :put, url, data, options
    end

    def path(url, data = nil, options = {})
      request :path, url, data, options
    end

    def delete(url, data = nil, options = {})
      request :delete, url, data, options
    end

    def head(url, options = {})
      request :head, url, options
    end

    def conn
      @conn ||= connection
    end

    def last_response
      @last_response if defined? @last_response
    end

    private

    def request(method, url, data = nil, options = {})
      if no_body?(method)
        options = data if options.empty?
        data = nil
      end

      @last_response = conn.send method, url do |req|
        req.body = data if data
        if (params = options[:query])
          req.params.update params
        end
        if (headers = options[:headers])
          req.headers.update headers
        end
      end

      @last_response.body
    end

    def connection
      conn_opts = @connection_options.dup
      conn_opts[:builder] = @middleware if @middleware
      conn_opts[:proxy] = @proxy if @proxy
      Faraday.new(conn_opts) do |conn|
        conn.basic_auth(@login, @password) if basic_authenticated?
        conn.url_prefix = api_endpoint
      end
    end

    def no_body?(method)
      [:get, :head].include?(method)
    end
  end
end
