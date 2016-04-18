require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :coverage do
  require 'simplecov'
  SimpleCov.start
  Rake::Task[:spec].execute
end
