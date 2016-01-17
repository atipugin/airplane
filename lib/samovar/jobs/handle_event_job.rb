module Samovar
  module Jobs
    class HandleEventJob < BaseJob
      def perform(params_dump)
        params = YAML.load(params_dump)
        handler = params[:handler]
        event = Samovar.store.find_event(params[:event_id])

        return unless conditions_satisfied?(handler, event)

        handler[:klass].new.run(event)
        enqueue_repeat(handler, params)
      end

      private

      def conditions_satisfied?(handler, event)
        subsequent_events =
          apply_constraints(
            handler,
            event,
            Samovar.store.find_subsequent_events(event)
          )

        if_satisfied?(handler, subsequent_events) &&
          unless_satisfied?(handler, subsequent_events)
      end

      def apply_constraints(handler, event, subsequent_events)
        return subsequent_events unless handler[:constraints]

        constraints = Array(handler[:constraints]).map(&:to_s)
        subsequent_events.select do |item|
          constraints.all? do |constraint|
            item['properties'][constraint] == event['properties'][constraint]
          end
        end
      end

      def if_satisfied?(handler, subsequent_events)
        return true unless handler[:if]
        subsequent_events.map { |e| e['name'] }.include?(handler[:if].to_s)
      end

      def unless_satisfied?(handler, subsequent_events)
        return true unless handler[:unless]
        !subsequent_events.map { |e| e['name'] }.include?(handler[:unless].to_s)
      end

      def enqueue_repeat(handler, params)
        repeat = params[:repeat].to_i.next

        return if repeat >= handler[:repeats]

        self
          .class
          .set(wait: handler[:delay])
          .perform_later(YAML.dump(params.merge(repeat: repeat)))
      end
    end
  end
end
