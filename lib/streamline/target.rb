module Streamline
  module Target
    def track_event(name, properties = {})
      Streamline.tracker.track_event(self, name, properties)
    end
  end
end
