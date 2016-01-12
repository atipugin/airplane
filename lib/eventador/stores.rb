require 'eventador/stores/base_store'
require 'eventador/stores/active_record_store' if defined?(ActiveRecord)

module Eventador
  def store
    @store ||= Stores::ActiveRecordStore.new
  end

  module_function :store
end
