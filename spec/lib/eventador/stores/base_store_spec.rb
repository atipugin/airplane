module Eventador
  module Stores
    RSpec.describe BaseStore do
      %w(save_event find_event).each do |method_name|
        describe method_name do
          it 'fails' do
            expect { subject.send(method_name) }
              .to raise_error(NotImplementedError)
          end
        end
      end
    end
  end
end
