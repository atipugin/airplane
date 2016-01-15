RSpec.shared_context 'event' do
  let(:event_name) { FFaker::Lorem.word }
  let(:event_properties) { { str: FFaker::Lorem.word, int: rand(1..9) } }
  let(:event_options) { { occurred_at: Time.now } }
  let(:event_id) do
    Eventador.store.save_event(event_name, event_properties, event_options)
  end
  let(:event) { Eventador.store.find_event(event_id) }
end
