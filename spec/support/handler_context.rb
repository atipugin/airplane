RSpec.shared_context 'handler' do
  let(:handler_class) { TestHandler }
  let(:handler_event_name) { FFaker::Lorem.word }
  let(:handler_options) { {} }
end
