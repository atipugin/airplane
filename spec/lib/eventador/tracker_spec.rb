module Eventador
  RSpec.describe Tracker do
    include_context 'event'

    describe '#track_event' do
      it 'enqueues event tracking job' do
        expect { subject.track_event(event_name) }
          .to enqueue_a(Eventador::Jobs::TrackEventJob)
      end
    end
  end
end
