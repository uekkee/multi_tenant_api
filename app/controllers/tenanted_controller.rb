class TenantedController < ApplicationController
  around_action :detect_tenant_db

  private

  def detect_tenant_db
    TenantRecord.connected_to(shard: shard_name, role: :writing) do
      yield
    end
  end

  def shard_name
    tenant_id = request.path.match(/\/tenants\/(\d+)\//)[1]
    Common::TenantDbShard.shard_name tenant_id
  end
end
