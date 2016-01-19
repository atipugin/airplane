module Streamline
  module Jobs
    RSpec.describe HandleEventJob do
      include_context 'event'
      include_context 'handler'

      let(:handler) { Streamline.registry[event_name].sample }
      let(:params) { { event_id: event_id, handler: handler } }
      let(:params_dump) { YAML.dump(params) }

      before do
        handler_class.handle(event_name, handler_options)
      end

      describe '#perform' do
        it 'runs handler' do
          allow_any_instance_of(handler_class).to receive(:run).with(event)
          subject.perform(params_dump)
        end
      end
    end
  end
end
