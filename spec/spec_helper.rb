require 'webmock/rspec'
require 'pry'

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'omnidesk_api'

WebMock.disable_net_connect!(allow: 'codeclimate.com')

RSpec.configure do |config|
end
