module Streamline
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

      def prepare_event(hsh)
        hsh.deep_stringify_keys
      end
    end
  end
end
