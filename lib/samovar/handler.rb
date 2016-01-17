module Samovar
  module Handler
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def handle(event_name, options = {})
        Samovar.registry.add(self, event_name, options)
      end
    end
  end
end
