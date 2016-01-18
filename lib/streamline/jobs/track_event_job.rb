module Streamline
  module Jobs
    class TrackEventJob < BaseJob
      def perform(params_dump)
        params = YAML.load(params_dump)
        event_id = Streamline.store.save_event(params)
        Streamline.registry[params[:name]].each do |handler|
          HandleEventJob
            .set(wait: handler[:delay])
            .perform_later(YAML.dump(event_id: event_id, handler: handler))
        end
      end
    end
  end
end
