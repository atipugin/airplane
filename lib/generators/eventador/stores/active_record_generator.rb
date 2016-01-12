module Eventador
  module Generators
    module Stores
      class ActiveRecordGenerator < Rails::Generators::Base
        include Rails::Generators::Migration

        source_root File.expand_path('../templates/active_record', __FILE__)

        def self.next_migration_number(*)
          Time.now.utc.strftime('%Y%m%d%H%M%S')
        end

        def copy_migrations
          migration_template 'create_events.rb',
                             'db/migrate/create_eventador_events.rb'
        end

        def copy_models
          copy_file 'event.rb', 'app/models/eventador/event.rb'
        end
      end
    end
  end
end
