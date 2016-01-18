module Airplane
  module Jobs
    class BaseJob < ActiveJob::Base
      queue_as :airplane
    end
  end
end
