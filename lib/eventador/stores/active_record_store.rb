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
        prepare_event(model.find(id).attributes)
      end

      def find_subsequent_events(event)
        model
          .where('occurred_at > ?', event['occurred_at'])
          .order('occurred_at ASC')
          .map { |e| prepare_event(e.attributes) }
      end

      private

      def model
        Eventador::Event
      end
    end
  end
end
