module Eventador
  module Stores
    class ActiveRecordStore < BaseStore
      extend Forwardable

      def_delegators :model, :count

      def save_event(name, properties, options)
        event = model.new do |e|
          e.id = generate_event_id
          e.name = name
          e.properties = properties
          e.occurred_at = options[:occurred_at]
        end

        event.save!
        event.id
      end

      def find_event(id)
        model.find(id).attributes
      end

      private

      def model
        Eventador::Event
      end
    end
  end
end
