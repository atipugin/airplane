module Samovar
  module Jobs
    class BaseJob < ActiveJob::Base
      queue_as :samovar
    end
  end
end
