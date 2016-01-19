lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'streamline/version'

Gem::Specification.new do |spec|
  spec.name = 'streamline'
  spec.version = Streamline::VERSION
  spec.summary = 'Simplify event-based behavior in your app'
  spec.authors = ['Alexander Tipugin']

  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(%r{^spec\/})
  spec.require_paths = %w(lib)

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'activejob'

  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-activejob'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
end
