module Eventador
  module Stores
    class BaseStore
      def save_event(*)
        not_implemented!
      end

      def find_event(*)
        not_implemented!
      end

      def find_subsequent_events(*)
        not_implemented!
      end

      private

      def not_implemented!
        fail NotImplementedError, 'You need to implement this method first'
      end

      def generate_event_id
        SecureRandom.uuid
      end
    end
  end
end
