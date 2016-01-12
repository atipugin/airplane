module Eventador
  class Event < ActiveRecord::Base
    self.table_name = 'eventador_events'

    serialize :properties

    validates :name, presence: true
    validates :occurred_at, presence: true
  end
end
