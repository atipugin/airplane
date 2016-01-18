module Streamline
  class Configuration
    attr_accessor :store

    def initialize
      @store = :active_record
    end
  end

  def configure
    yield(configuration) if block_given?
  end

  def configuration
    @configuration ||= Configuration.new
  end

  module_function :configure, :configuration
end
