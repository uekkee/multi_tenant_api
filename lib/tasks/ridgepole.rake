# frozen_string_literal: true

namespace :ridgepole do
  desc 'Apply common database schema'
  task common_apply: :environment do
    apply 'common', 'db/common/Schemafile'
  end

  desc 'Apply tenant database schema'
  task :tenant_apply, ['tenant_id'] => :environment do |_task, args|
    apply "tenant_#{args.tenant_id}", 'db/tenant/Schemafile'
  end

  private

  def ridgepole(*options)
    command = ['bundle exec ridgepole']
    system((command + options).join(' '))
  end

  def draw_config(db_name)
    Rails.application.config.database_configuration[Rails.env][db_name.to_s]
  end

  def shape_config_str(db_name)
    config_str = draw_config(db_name).to_s
    config_str.gsub(/>|=/, '>' => '', '=' => ':')
  end

  def apply(db_name, schema_file)
    ridgepole("--file #{schema_file}", "--config '#{shape_config_str(db_name)}'", \
              "--env #{Rails.env}", '--apply')
  end
end
