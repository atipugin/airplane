module Airplane
  module Target
    def track_event(name, properties = {})
      Airplane.tracker.track_event(self, name, properties)
    end
  end
end
