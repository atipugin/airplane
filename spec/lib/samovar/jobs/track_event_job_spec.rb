module Samovar
  module Jobs
    RSpec.describe TrackEventJob do
      include_context 'event'
      include_context 'handler'

      let(:params_dump) { YAML.dump(event_attributes) }

      describe '#perform' do
        it 'invokes store to save event' do
          expect(Samovar.store).to receive(:save_event)
          subject.perform(params_dump)
        end

        context 'when event has registered handlers' do
          before do
            handler_class.handle event_name
          end

          it 'enqueues event handling' do
            expect { subject.perform(params_dump) }
              .to enqueue_a(Samovar::Jobs::HandleEventJob)
          end
        end
      end
    end
  end
end
