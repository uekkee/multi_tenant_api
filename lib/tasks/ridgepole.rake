# frozen_string_literal: true

namespace :ridgepole do
  desc 'Apply schema to common db'
  task apply_common: :environment do
    config = Rails.application.config.database_configuration[Rails.env]['common']
    apply config, 'db/common/Schemafile'
  end

  desc 'Apply schema to tenant dbs'
  task apply_tenants: :environment do
    Common::TenantDbConnection.where(role: :writing).each do |db_connection|
      config = db_connection.build_connection_config
      apply config, 'db/tenant/Schemafile'
    end
  end

  private

  def ridgepole(*options)
    command = ['bundle exec ridgepole']
    system((command + options).join(' '))
  end

  def shape_config_str(db_config)
    config_str = db_config.to_s
    config_str.gsub(/>|=/, '>' => '', '=' => ':')
  end

  def apply(config, schema_file)
    ridgepole("--file #{schema_file}", "--config '#{shape_config_str(config)}'", \
              "--env #{Rails.env}", '--apply')
  end
end
