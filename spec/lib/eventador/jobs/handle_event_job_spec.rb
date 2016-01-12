module Eventador
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'
      include_context 'handler'

      let(:event_id) do
        Eventador.store.save_event(event_name, event_properties, event_options)
      end
      let(:params_dump) do
        YAML.dump(
          event_id: event_id,
          handler: Eventador.registry[event_name][0]
        )
      end

      before do
        handler_klass.handle event_name
      end

      describe '#perform' do
        it 'runs handler' do
          # ...
        end
      end
    end
  end
end
