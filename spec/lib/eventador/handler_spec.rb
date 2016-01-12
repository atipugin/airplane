module Eventador
  RSpec.describe Handler do
    include_context 'handler'

    it 'adds .handle method' do
      expect(handler_klass).to respond_to(:handle)
    end

    describe '.handle' do
      it 'adds handler to the registry' do
        expect(Eventador.registry).to receive(:add)
        handler_klass.handle(handler_event_name, handler_options)
      end
    end
  end
end
