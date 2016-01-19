RSpec.describe Streamline do
  describe '.configure' do
    let(:new_value) { random_word }
    let!(:old_value) { described_class.configuration.store }

    it 'allows to change config params' do
      expect { described_class.configure { |c| c.store = new_value } }
        .to change(described_class.configuration, :store).to(new_value)
    end

    after(:each) do
      described_class.configure { |c| c.store = old_value }
    end
  end

  describe '.tracker' do
    it 'returns instance of Tracker' do
      expect(described_class.tracker).to be_a(Streamline::Tracker)
    end
  end
end
