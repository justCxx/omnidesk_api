require 'omnidesk_api/client'
require 'omnidesk_api/default'
require 'omnidesk_api/version'

# Ruby toolkit for the Omnidesk API
module OmnideskApi
  class << self
    include OmnideskApi::Configurable

    # API client based on configured options {Configurable}
    #
    # @return [OmnideskApi::Client] API wrapper
    def client
      return @client if defined?(@client) && @client.same_options?(options)
      @client = OmnideskApi::Client.new(options)
    end

    private

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      return client.send(method_name, *args, &block) if client.respond_to?(method_name)
      super
    end
  end
end

OmnideskApi.setup
