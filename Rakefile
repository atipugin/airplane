require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'bundler/gem_tasks'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = false
  task.patterns = %w({lib,spec}/**/*.rb)
  task.requires << 'rubocop-rspec'
end

task default: :spec
