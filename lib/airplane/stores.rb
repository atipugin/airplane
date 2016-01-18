require 'airplane/stores/base_store'
require 'airplane/stores/active_record_store' if defined?(ActiveRecord)

module Airplane
  def store
    @store ||= begin
      klass = case configuration.store
              when :active_record then Stores::ActiveRecordStore
              end

      klass.new
    end
  end

  module_function :store
end
