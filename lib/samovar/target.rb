module Samovar
  module Target
    def track_event(name, properties = {})
      Samovar.tracker.track_event(self, name, properties)
    end
  end
end
