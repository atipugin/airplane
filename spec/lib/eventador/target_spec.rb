module Eventador
  RSpec.describe Target do
    include described_class

    include_context 'event'

    subject { Class.new { include Eventador::Target } }

    describe '#track_event' do
      it 'invokes Tracker' do
        expect(Eventador.tracker).to receive(:track_event)
        track_event(event_name)
      end
    end
  end
end
