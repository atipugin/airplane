module Streamline
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'
      include_context 'handler'

      let(:handler) { Streamline.registry[event_name].sample }
      let(:subsequent_events) { Streamline.store.find_subsequent_events(event) }
      let(:params) { { event_id: event_id, handler: handler } }

      before do
        handler_class.handle event_name, handler_options
      end

      describe '#conditions_satisfied?' do
        it 'returns true' do
          expect(subject.send(:conditions_satisfied?, handler, event))
            .to be(true)
        end
      end

      describe '#if_satisfied?' do
        let(:handler_options) { { if: FFaker::Lorem.word } }

        it 'returns false' do
          expect(subject.send(:if_satisfied?, handler, subsequent_events))
            .to be(false)
        end

        context 'when expected event is occurred' do
          before do
            Streamline.store.save_event(
              event_attributes.merge(
                name: handler_options[:if],
                occurred_at: 1.minute.from_now
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
        let(:handler_options) { { unless: FFaker::Lorem.word } }

        it 'returns true' do
          expect(subject.send(:unless_satisfied?, handler, subsequent_events))
            .to be(true)
        end

        context 'when unexpected event is occurred' do
          before do
            Streamline.store.save_event(
              event_attributes.merge(
                name: handler_options[:unless],
                occurred_at: 1.minute.from_now
              )
            )
          end

          it 'returns false' do
            expect(subject.send(:unless_satisfied?, handler, subsequent_events))
              .to be(false)
          end
        end
      end

      describe '#apply_constraints' do
        let(:event_properties) { { user_id: rand(1..10) } }
        let(:handler_options) { { constraints: :user_id } }

        before do
          Streamline.store.save_event(
            event_attributes.merge(occurred_at: 1.minute.from_now)
          )
        end

        it 'returns suitable events' do
          expect(
            subject
              .send(:apply_constraints, handler, event, subsequent_events)
              .sample['properties']
          ).to include('user_id' => event_properties[:user_id])
        end
      end

      describe '#enqueue_repeat' do
        it 'does not enqueue itself again' do
          expect { subject.send(:enqueue_repeat, handler, params) }
            .not_to enqueue_a(described_class)
        end

        context 'when amount of handler repeats is greater than one' do
          let(:handler_options) { { repeats: 2 } }

          it 'enqueues itself again' do
            expect { subject.send(:enqueue_repeat, handler, params) }
              .to enqueue_a(described_class)
          end
        end
      end
    end
  end
end
