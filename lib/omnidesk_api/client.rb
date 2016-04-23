require 'omnidesk_api/authentication'
require 'omnidesk_api/configurable'
require 'omnidesk_api/connection'
require 'omnidesk_api/client/cases'
require 'omnidesk_api/client/users'
require 'omnidesk_api/client/groups'
require 'omnidesk_api/client/labels'
require 'omnidesk_api/client/staff'
require 'omnidesk_api/client/stats'
require 'omnidesk_api/client/custom_fields'
require 'omnidesk_api/client/knowledge_base/article'
require 'omnidesk_api/client/knowledge_base/category'
require 'omnidesk_api/client/knowledge_base/section'

module OmnideskApi
  class Client
    include OmnideskApi::Authentication
    include OmnideskApi::Configurable
    include OmnideskApi::Connection

    include OmnideskApi::Client::Cases
    include OmnideskApi::Client::Users
    include OmnideskApi::Client::Groups
    include OmnideskApi::Client::Labels
    include OmnideskApi::Client::Staff
    include OmnideskApi::Client::Stats
    include OmnideskApi::Client::CustomFields
    include OmnideskApi::Client::KnowledgeBase::Article
    include OmnideskApi::Client::KnowledgeBase::Category
    include OmnideskApi::Client::KnowledgeBase::Section

    def initialize(options = {})
      # Use options passed in, but fall back to module defaults
      OmnideskApi::Configurable.keys.each do |key|
        value = options[key] || OmnideskApi.instance_variable_get(:"@#{key}")
        instance_variable_set(:"@#{key}", value)
      end
    end

    def inspect
      super.tap do |inspected|
        inspected.gsub! @password, '*******' if @password
      end
    end

    def login=(value)
      reset_connection!
      @login = value
    end

    def password=(value)
      reset_connection!
      @password = value
    end
  end
end
