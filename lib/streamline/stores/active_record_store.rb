module Streamline
  module Stores
    class ActiveRecordStore < BaseStore
      extend Forwardable

      def_delegators :model, :count

      def save_event(attributes)
        model.create!(attributes).id
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
        Streamline::Event
      end
    end
  end
end
