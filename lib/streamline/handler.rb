module Streamline
  module Handler
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def handle(event_name, options = {})
        Streamline.registry.add(self, event_name, options)
      end
    end
  end
end
