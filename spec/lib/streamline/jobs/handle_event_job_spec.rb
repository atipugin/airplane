module Streamline
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'
      include_context 'handler'

      let(:handler) { Streamline.registry[event_name].sample }
      let(:params) { { event_id: event_id, handler: handler } }
      let(:params_dump) { YAML.dump(params) }
      let(:subsequent_events) { Streamline.store.find_subsequent_events(event) }

      before do
        handler_class.handle(event_name, handler_options)
      end

      describe '#perform' do
        it 'runs handler' do
          allow_any_instance_of(handler_class).to receive(:run).with(event)
          subject.perform(params_dump)
        end
      end

      describe '#conditions_satisfied?' do
        it 'returns true' do
          expect(subject.send(:conditions_satisfied?, handler, event))
            .to be(true)
        end

        context 'when handler conditions are not satisfied' do
          let(:handler_options) { { if: random_word } }

          it 'returns false' do
            expect(subject.send(:conditions_satisfied?, handler, event))
              .to be(false)
          end
        end
      end

      describe '#if_satisfied?' do
        let(:handler_options) { { if: random_word } }

        it 'returns false' do
          expect(subject.send(:if_satisfied?, handler, subsequent_events))
            .to be(false)
        end

        context 'when expected event is occurred' do
          before do
            Streamline.store.save_event(
              event_attributes.merge(
                name: handler_options[:if],
                occurred_at: 1.hour.from_now
              )
            )
          end

          it 'returns true' do
            expect(subject.send(:if_satisfied?, handler, subsequent_events))
              .to be(true)
          end
        end
      end

      describe '#unless_satisfied?' do
        let(:handler_options) { { unless: random_word } }

        it 'returns true' do
          expect(subject.send(:unless_satisfied?, handler, subsequent_events))
            .to be(true)
        end

        context 'when unexpected event is occurred' do
          before do
            Streamline.store.save_event(
              event_attributes.merge(
                name: handler_options[:unless],
                occurred_at: 1.hour.from_now
              )
            )
          end

          it 'returns false' do
            expect(subject.send(:unless_satisfied?, handler, subsequent_events))
              .to be(false)
          end
        end
      end

      describe '#enqueue_repeat' do
        it 'does not enqueue another repeat' do
          expect { subject.send(:enqueue_repeat, handler, params) }
            .not_to enqueue_a(described_class)
        end

        describe 'when amount of repeats greater than one' do
          let(:handler_options) { { repeats: 2 } }

          it 'enqueues another repeat' do
            expect { subject.send(:enqueue_repeat, handler, params) }
              .to enqueue_a(described_class)
          end
        end
      end
    end
  end
end
