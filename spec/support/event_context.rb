RSpec.shared_context 'event' do
  let(:event_name) { FFaker::Lorem.word }
  let(:event_properties) { {} }
  let(:event_target) { OpenStruct.new(id: rand(1..9)) }
  let(:event_attributes) do
    { name: event_name,
      properties: event_properties,
      occurred_at: Time.zone.now }
  end
  let(:event_id) { Streamline.store.save_event(event_attributes) }
  let(:event) { Streamline.store.find_event(event_id) }
end
