RSpec.shared_context 'handler' do
  let(:klass) { TestHandler }
  let(:event_name) { FFaker::Lorem.word }
  let(:options) { {} }
end
