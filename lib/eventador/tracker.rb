module Eventador
  class Tracker
    def track_event(name, properties = {})
      Jobs::TrackEventJob
        .perform_later(
          YAML.dump(name: name, properties: properties, options: options)
        )
    end

    def options
      { occurred_at: Time.now }
    end
  end

  def tracker
    @tracker ||= Tracker.new
  end

  module_function :tracker
end
