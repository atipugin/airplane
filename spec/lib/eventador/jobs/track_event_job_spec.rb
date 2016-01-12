module Eventador
  module Jobs
    RSpec.describe TrackEventJob do
      include_context 'event'

      let(:params_dump) do
        YAML.dump(
          name: event_name,
          properties: event_properties,
          options: event_options
        )
      end

      describe '#perform' do
        it 'invokes store to save event' do
          expect(Eventador.store).to receive(:save_event)
          subject.perform(params_dump)
        end

        context 'when event has registered handlers' do
          before do
            TestHandler.handle event_name
          end

          it 'enqueues event handling' do
            expect { subject.perform(params_dump) }
              .to enqueue_a(Eventador::Jobs::HandleEventJob)
          end
        end
      end
    end
  end
end
