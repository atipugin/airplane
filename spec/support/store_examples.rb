RSpec.shared_examples_for 'a store' do
  include_context 'event'

  describe '#save_event' do
    it 'saves event to the store' do
      expect { subject.save_event(name, properties, options) }
        .to change(subject, :count).by(1)
    end

    it 'returns id of saved event' do
      expect(subject.save_event(name, properties, options)).to be_a(String)
    end
  end

  describe '#find_event' do
    let(:id) { subject.save_event(name, properties, options) }

    it 'returns saved event as a hash' do
      expect(subject.find_event(id)).to be_a(Hash)
    end

    it 'returns valid name' do
      expect(subject.find_event(id)['name']).to eq(name)
    end

    it 'returns valid properties' do
      expect(subject.find_event(id)['properties']).to eq(properties)
    end

    it 'returns valid time of occurrance' do
      expect(subject.find_event(id)['occurred_at']).to eq(options[:occurred_at])
    end
  end
end
