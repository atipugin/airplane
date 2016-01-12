require 'ffaker'
require 'rspec/active_job'
require 'simplecov'

require 'active_record'
require 'activeuuid'

SimpleCov.start

require 'eventador'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.include RSpec::ActiveJob
end
