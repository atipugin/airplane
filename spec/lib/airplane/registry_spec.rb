module Airplane
  RSpec.describe Registry do
    include_context 'handler'

    describe '#add' do
      it 'adds an item' do
        expect do
          subject.add(handler_class, handler_event_name, handler_options)
        end.to change(subject, :count).by(1)
      end

      context 'when item is already added' do
        before do
          subject.add(handler_class, handler_event_name, handler_options)
        end

        it 'does not add it twice' do
          expect do
            subject.add(handler_class, handler_event_name, handler_options)
          end.not_to change(subject, :count)
        end
      end
    end
  end
end
