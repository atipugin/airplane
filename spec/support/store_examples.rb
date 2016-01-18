RSpec.shared_examples_for 'a store' do
  include_context 'event'

  describe '#save_event' do
    it 'saves event to the store' do
      expect { subject.save_event(event_attributes) }
        .to change(subject, :count).by(1)
    end

    it 'returns id of saved event' do
      expect(subject.save_event(event_attributes)).to be_a(String)
    end
  end

  describe '#find_event' do
    it 'returns saved event as a hash' do
      expect(subject.find_event(event_id)).to be_a(Hash)
    end

    it 'returns valid name' do
      expect(subject.find_event(event_id)['name']).to eq(event_name)
    end

    it 'returns valid properties' do
      expect(subject.find_event(event_id)['properties'])
        .to eq(event_attributes[:properties])
    end

    it 'returns valid time of occurrance' do
      expect(subject.find_event(event_id)['occurred_at'])
        .to eq(event_attributes[:occurred_at])
    end

    it 'returns hash with string keys' do
      expect(subject.find_event(event_id).keys.sample).to be_a(String)
    end
  end

  describe '#find_subsequent_events' do
    before do
      Airplane.store.save_event(
        event_attributes.merge(occurred_at: 1.minute.from_now)
      )
    end

    it 'returns an array' do
      expect(subject.find_subsequent_events(event)).to be_a(Array)
    end

    it 'returns items as hashes' do
      expect(subject.find_subsequent_events(event).sample).to be_a(Hash)
    end

    it 'returns events in ascending order' do
      events = subject.find_subsequent_events(event)
      expect(events.first['occurred_at']).to be <= events.last['occurred_at']
    end
  end
end
