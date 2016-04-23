source 'https://rubygems.org'

# Specify your gem's dependencies in omnidesk_api.gemspec
gemspec

gem 'rake'

group :development do
  gem 'pry-byebug'
  gem 'yard'
  gem 'typhoeus'
end

group :test do
  gem 'rspec', '~> 3.0'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end

gem 'dotenv', groups: [:development, :test]
gem 'awesome_print', require: 'ap', groups: [:development, :test]
