module Eventador
  module Jobs
    RSpec.describe TrackEventJob do
      include_context 'event'

      let(:params_dump) do
        YAML.dump(name: name, properties: properties, options: options)
      end

      describe '#perform' do
        it 'invokes store to save event' do
          expect(Eventador.store).to receive(:save_event)
          subject.perform(params_dump)
        end

        context 'when event has registered handlers' do
          before do
            TestHandler.handle name
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
