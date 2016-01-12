module Eventador
  module Jobs
    class TrackEventJob < BaseJob
      def perform(name, properties, options)
        Eventador.store.save_event(name, properties, options)
      end
    end
  end
end
