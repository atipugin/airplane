module Eventador
  module Jobs
    class HandleEventJob < BaseJob
      def perform(params_dump)
        params = YAML.load(params_dump)
        event = Eventador.store.find_event(params[:event_id])
        params[:handler][:klass].new.run(event)
      end
    end
  end
end
