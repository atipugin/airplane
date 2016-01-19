ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  create_table :streamline_events do |t|
    t.string :name, null: false
    t.text :properties
    t.datetime :occurred_at, null: false
    t.references :target, polymorphic: true
  end

  add_index :streamline_events, [:target_type, :target_id]
end

module Streamline
  class Event < ActiveRecord::Base
    self.table_name = 'streamline_events'

    serialize :properties

    belongs_to :target, polymorphic: true

    validates :name, presence: true
    validates :occurred_at, presence: true
  end
end
