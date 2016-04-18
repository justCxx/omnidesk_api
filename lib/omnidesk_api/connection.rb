require 'faraday'
require 'sawyer'
require 'omnidesk_api/authentication'

module OmnideskApi
  # Network layer for API client
  module Connection
    include OmnideskApi::Authentication

    # Header keys that can be passed in options hash to {#get},{#head}
    CONVENIENCE_HEADERS = Set.new([:accept, :content_type])

    def get(url, options = {})
      request :get, url, parse_query_and_convenience_headers(options)
    end

    def post(url, options = {})
      request :post, url, options
    end

    def put(url, options = {})
      request :put, url, options
    end

    def path(url, options = {})
      request :path, url, options
    end

    def delete(url, options = {})
      request :delete, url, options
    end

    def head(url, options = {})
      request :head, url, parse_query_and_convenience_headers(options)
    end

    # @return [Sawyer::Agent]
    def agent
      @agent ||= Sawyer::Agent.new(endpoint, sawyer_options) do |http|
        http.headers[:content_type] = 'application/json'
        http.headers[:user_agent] = user_agent
        http.basic_auth(@login, @password) if basic_authenticated?
      end
    end

    # Response for last HTTP request
    #
    # @return [Sawyer::Response]
    def last_response
      @last_response if defined? @last_response
    end

    protected

    def endpoint
      api_endpoint
    end

    private

    def request(method, path, data, options = {})
      if data.is_a?(Hash)
        options[:query]   = data.delete(:query) || {}
        options[:headers] = data.delete(:headers) || {}
      end

      @last_response = response = agent.call(method, URI::Parser.new.escape(path.to_s), data, options)
      response.data
    end

    def sawyer_options
      opts = { links_parser: Sawyer::LinkParsers::Simple.new }

      conn_opts = @connection_options
      conn_opts[:builder] = @middleware if @middleware
      conn_opts[:proxy] = @proxy if @proxy
      opts[:faraday] = Faraday.new(conn_opts)

      opts
    end

    def parse_query_and_convenience_headers(options)
      headers = options.delete(:headers) { Hash.new }
      CONVENIENCE_HEADERS.each do |h|
        if (header = options.delete(h))
          headers[h] = header
        end
      end
      query = options.delete(:query)
      opts = { query: options }
      opts[:query].merge!(query) if query && query.is_a(Hash)
      opts[:headers] = headers unless headers.empty?

      opts
    end
  end
end
