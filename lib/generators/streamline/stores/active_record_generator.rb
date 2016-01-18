module Streamline
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
                             'db/migrate/create_streamline_events.rb'
        end

        def copy_models
          template 'event.rb', 'app/models/streamline/event.rb'
        end

        def jsonb?
          return false unless postgresql?

          ActiveRecord::Base
            .connection
            .execute('SELECT version();')[0]['version']
            .start_with?('PostgreSQL 9.4')
        end

        def postgresql?
          config = ActiveRecord::Base.configurations[Rails.env]
          config && config['adapter'] == 'postgresql'
        end
      end
    end
  end
end
