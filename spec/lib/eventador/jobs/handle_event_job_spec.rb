module Eventador
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'

      let(:event_id) { Eventador.store.save_event(name, properties, options) }
      let(:handler_klass) { TestHandler }
      let(:params_dump) do
        YAML.dump(event_id: event_id, handler: Eventador.registry[name][0])
      end

      before do
        handler_klass.handle name
      end

      describe '#perform' do
        it 'runs handler' do
          # ...
        end
      end
    end
  end
end
