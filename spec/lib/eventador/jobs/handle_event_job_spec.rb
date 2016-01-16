module Eventador
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'
      include_context 'handler'

      let(:event_id) do
        Eventador.store.save_event(event_name, event_properties, event_options)
      end
      let(:handler) { Eventador.registry[event_name][0] }
      let(:params_dump) { YAML.dump(event_id: event_id, handler: handler) }
      let(:subsequent_events) do
        Eventador.store.find_subsequent_events(event)
      end

      before do
        handler_klass.handle event_name, handler_options
      end

      describe '#perform' do
        it 'runs handler' do
          # ...
        end
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
            Eventador.store.save_event(
              handler_options[:if],
              event_properties,
              event_options.merge(occurred_at: 1.minute.from_now)
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
            Eventador.store.save_event(
              handler_options[:unless],
              event_properties,
              event_options.merge(occurred_at: 1.minute.from_now)
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
          Eventador.store.save_event(
            event_name,
            event_properties,
            event_options.merge(occurred_at: 1.minute.from_now)
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
    end
  end
end
