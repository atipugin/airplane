module Eventador
  module Jobs
    RSpec.describe TrackEventJob do
      include_context 'event'

      describe '#perform' do
        it 'invokes store to save event' do
          expect(Eventador.store).to receive(:save_event)
          subject.perform(name, properties, options)
        end
      end
    end
  end
end
