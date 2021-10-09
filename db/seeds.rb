# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..3).each do |tenant_id|
  Common::Tenant.find_or_initialize_by(id: tenant_id).tap do |tenant|
    tenant.update! name: "テナント #{tenant_id}",
                   email: "tenant_#{tenant_id}@example.com"
  end

  Common::TenantDbShard.find_or_initialize_by(tenant_id: tenant_id).tap do |db_shard|
    db_shard.save!

    %w[writing reading].each do |role|
      Common::TenantDbConnection.find_or_initialize_by(shard_id: db_shard.id, role: role).tap do |db_connection|
        db_connection.update! host: '127.0.0.1',
                              username: 'postgres',
                              database: "multi_tenant_api_tenant_#{sprintf '%08d', tenant_id}_development"
      end
    end
  end
end
