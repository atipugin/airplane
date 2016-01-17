module Eventador
  class Event < ActiveRecord::Base
    self.table_name = 'eventador_events'

    serialize :properties

    belongs_to :target, polymorphic: true

    validates :name, presence: true
    validates :occurred_at, presence: true
  end
end
