module OmnideskApi
  module Configurable
    attr_accessor :auto_paginate, :connection_options, :middleware,
                  :per_page, :proxy, :user_agent
    attr_writer :login, :password, :api_endpoint

    class << self
      def keys
        @keys ||= [
          :api_endpoint,
          :auto_paginate,
          :connection_options,
          :middleware,
          :login,
          :password,
          :per_page,
          :proxy,
          :user_agent
        ]
      end
    end

    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      OmnideskApi::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", OmnideskApi::Default.options[key])
      end
      self
    end
    alias setup reset!

    # Compares client options to a Hash of requested options
    #
    # @param opts [Hash] Options to compare with current client options
    # @return [Boolean]
    def same_options?(opts)
      opts.hash == options.hash
    end

    def api_endpoint
      File.join(@api_endpoint, '')
    end

    private

    def options
      Hash[OmnideskApi::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end
