module Eventador
  class Registry
    extend Forwardable

    def_delegators :@items, :count

    def initialize
      @items = {}
    end

    def add(klass, event_name, options = {})
      return if self[event_name].map { |h| h[:klass] }.include?(klass)
      self[event_name] << default_options.merge(options).merge(klass: klass)
    end

    def [](event_name)
      @items[event_name.to_s] ||= []
    end

    private

    def default_options
      {}
    end
  end

  def registry
    @registry ||= Registry.new
  end

  module_function :registry
end
