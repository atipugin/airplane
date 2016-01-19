RSpec.shared_context 'handler' do
  let(:handler_class) { TestHandler }
  let(:handler_event_name) { random_word }
  let(:handler_options) { {} }
end
