module Streamline
  module Jobs
    class BaseJob < ActiveJob::Base
      queue_as :streamline
    end
  end
end
