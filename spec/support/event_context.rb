RSpec.shared_context 'event' do
  let(:event_name) { FFaker::Lorem.word }
  let(:event_properties) { { str: FFaker::Lorem.word, int: rand(1..9) } }
  let(:event_options) { { occurred_at: Time.now } }
end
