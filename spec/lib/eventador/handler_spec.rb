module Eventador
  RSpec.describe Handler do
    include_context 'handler'

    it 'adds .handle method' do
      expect(klass).to respond_to(:handle)
    end

    describe '.handle' do
      it 'adds handler to the registry' do
        expect(Eventador.registry).to receive(:add)
        klass.handle(event_name, options)
      end
    end
  end
end
