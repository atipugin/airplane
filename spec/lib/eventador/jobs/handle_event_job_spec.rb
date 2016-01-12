module Eventador
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'

      let(:event_id) { Eventador.store.save_event(name, properties, options) }
      let(:handler_dump) { YAML.dump(Eventador.registry[name][0]) }
      let(:handler_klass) { TestHandler }

      before do
        handler_klass.handle name
      end

      describe '#perform' do
        it 'runs handler' do
          allow_any_instance_of(handler_klass).to receive(:run)
          subject.perform(event_id, handler_dump)
        end
      end
    end
  end
end
