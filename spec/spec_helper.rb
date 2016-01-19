require 'rspec/active_job'
require 'simplecov'
require 'database_cleaner'

require 'active_record'

SimpleCov.start

require 'streamline'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

ActiveJob::Base.queue_adapter = :test
Time.zone = 'UTC'

RSpec.configure do |config|
  config.include RSpec::ActiveJob
  config.include Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
