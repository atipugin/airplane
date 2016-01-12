RSpec.shared_context 'handler' do
  let(:handler_klass) { TestHandler }
  let(:handler_event_name) { FFaker::Lorem.word }
  let(:handler_options) { {} }
end
