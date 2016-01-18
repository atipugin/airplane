module Airplane
  class Tracker
    def track_event(target, name, properties = {})
      params =
        { name: name, properties: properties }
        .merge(options)
        .merge(extract_target_params(target))

      Jobs::TrackEventJob.perform_later(YAML.dump(params))
    end

    private

    def options
      { occurred_at: Time.now }
    end

    def extract_target_params(target)
      { target_type: Util.extract_object_type(target),
        target_id: Util.extract_object_id(target) }
    end
  end

  def tracker
    @tracker ||= Tracker.new
  end

  module_function :tracker
end
