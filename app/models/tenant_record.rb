class TenantRecord < ApplicationRecord
  self.abstract_class = true

  connects_to shards: {
    shard_tenant_1: { writing: :tenant_1, reading: :tenant_1 },
    shard_tenant_2: { writing: :tenant_2, reading: :tenant_2 },
  }
end
