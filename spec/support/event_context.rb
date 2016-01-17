RSpec.shared_context 'event' do
  let(:event_name) { FFaker::Lorem.word }
  let(:event_properties) { {} }
  let(:event_target) { OpenStruct.new(id: rand(1..9)) }
  let(:event_attributes) do
    { name: event_name, properties: event_properties, occurred_at: Time.now }
  end
  let(:event_id) { Eventador.store.save_event(event_attributes) }
  let(:event) { Eventador.store.find_event(event_id) }
end
