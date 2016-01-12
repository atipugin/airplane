RSpec.shared_context 'event' do
  let(:name) { FFaker::Lorem.word }
  let(:properties) { { str: FFaker::Lorem.word, int: rand(1..9) } }
  let(:options) { { occurred_at: Time.now } }
end
