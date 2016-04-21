require 'dotenv'
Dotenv.load

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'omnidesk_api'
require 'logger'
require 'pry'

OmnideskApi.configure do |config|
  logger = Logger.new('log/test.log')
  # logger.level = ::Logger::INFO
  config.middleware = Faraday::RackBuilder.new do |builder|
    builder.response :logger, logger, bodies: true
    builder.use OmnideskApi::Response::RaiseError
  end
end

RSpec.configure do |config|
end
