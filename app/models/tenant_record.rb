class TenantRecord < ApplicationRecord
  self.abstract_class = true

  connects_to shards: Common::TenantDbShard.build_shards_config
end
