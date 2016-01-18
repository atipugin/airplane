module Streamline
  RSpec.describe Tracker do
    include_context 'event'

    describe '#track_event' do
      it 'enqueues event tracking job' do
        expect { subject.track_event(event_target, event_name) }
          .to enqueue_a(Streamline::Jobs::TrackEventJob)
      end
    end
  end
end
