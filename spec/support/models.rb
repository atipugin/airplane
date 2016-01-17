ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  create_table :eventador_events, id: false do |t|
    t.uuid :id, primary_key: true
    t.string :name, null: false
    t.text :properties
    t.datetime :occurred_at, null: false
    t.references :target, polymorphic: true
  end

  add_index :eventador_events, :id
  add_index :eventador_events, [:target_type, :target_id]
end

module Eventador
  class Event < ActiveRecord::Base
    self.table_name = 'eventador_events'

    serialize :properties

    belongs_to :target, polymorphic: true

    validates :name, presence: true
    validates :occurred_at, presence: true
  end
end
