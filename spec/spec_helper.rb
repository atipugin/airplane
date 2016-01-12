require 'ffaker'
require 'rspec/active_job'

require 'active_record'
require 'activeuuid'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

require 'eventador'

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.include RSpec::ActiveJob
end
