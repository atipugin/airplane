module Eventador
  module Jobs
    class HandleEventJob < BaseJob
      def perform(event_id, handler_dump)
        event = Eventador.store.find_event(event_id)
        handler = YAML.load(handler_dump)
        handler[:klass].new.run(event)
      end
    end
  end
end
