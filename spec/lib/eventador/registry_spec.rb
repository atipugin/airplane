module Eventador
  RSpec.describe Registry do
    include_context 'handler'

    describe '#add' do
      it 'adds an item' do
        expect { subject.add(klass, event_name, options) }
          .to change(subject, :count).by(1)
      end

      context 'when item is already added' do
        before do
          subject.add(klass, event_name, options)
        end

        it 'does not add it twice' do
          expect { subject.add(klass, event_name, options) }
            .not_to change(subject, :count)
        end
      end
    end
  end
end
