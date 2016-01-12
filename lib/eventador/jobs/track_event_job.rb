module Eventador
  module Jobs
    class TrackEventJob < BaseJob
      def perform(name, properties, options)
        event_id = Eventador.store.save_event(name, properties, options)
        Eventador.registry[name].each do |hsh|
          HandleEventJob
            .set(wait: hsh[:delay])
            .perform_later(event_id, YAML.dump(hsh))
        end
      end
    end
  end
end
