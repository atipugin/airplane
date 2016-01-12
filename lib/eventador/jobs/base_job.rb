module Eventador
  module Jobs
    class BaseJob < ActiveJob::Base
      queue_as :eventador
    end
  end
end
