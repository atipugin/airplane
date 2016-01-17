module Eventador
  module Target
    def track_event(name, properties = {})
      Eventador.tracker.track_event(self, name, properties)
    end
  end
end
