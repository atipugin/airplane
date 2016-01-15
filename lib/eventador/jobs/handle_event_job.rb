module Eventador
  module Jobs
    class HandleEventJob < BaseJob
      def perform(params_dump)
        params = YAML.load(params_dump)
        handler = params[:handler]
        event = Eventador.store.find_event(params[:event_id])

        return unless conditions_satisfied?(handler, event)

        handler[:klass].new.run(event)
      end

      private

      def conditions_satisfied?(handler, event)
        subsequent_events =
          Eventador.store.find_subsequent_events(event).map { |e| e['name'] }

        if_satisfied?(handler, subsequent_events) &&
          unless_satisfied?(handler, subsequent_events)
      end

      def if_satisfied?(handler, subsequent_events)
        return true unless handler[:if]
        subsequent_events.include?(handler[:if].to_s)
      end

      def unless_satisfied?(handler, subsequent_events)
        return true unless handler[:unless]
        !subsequent_events.include?(handler[:unless].to_s)
      end
    end
  end
end
