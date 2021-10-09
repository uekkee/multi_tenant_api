# frozen_string_literal: true

namespace :tenant_dbs do
  desc 'create tenant dbs'
  task create: :environment do
    Common::TenantDbConnection.all.each do |db_connection|
      db_connection.create_tenant_db_if_not_exists
    end
  end

  desc 'drop tenant dbs'
  task drop: :environment do
    raise 'dropping tenant dbs can development env only' unless Rails.env.development?

    Common::TenantDbConnection.all.each do |db_connection|
      query = "DROP DATABASE IF EXISTS #{db_connection.database}"
      CommonRecord.connection.execute query
    end
  end
end
