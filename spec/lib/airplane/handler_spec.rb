module Airplane
  RSpec.describe Handler do
    include_context 'handler'

    it 'adds .handle method' do
      expect(handler_class).to respond_to(:handle)
    end

    describe '.handle' do
      it 'adds handler to the registry' do
        expect(Airplane.registry).to receive(:add)
        handler_class.handle(handler_event_name, handler_options)
      end
    end
  end
end
