module Airplane
  module Stores
    class ActiveRecordStore < BaseStore
      extend Forwardable

      def_delegators :model, :count

      def save_event(attributes)
        event = model.new(attributes)
        event.id = generate_event_id
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
        Airplane::Event
      end
    end
  end
end
