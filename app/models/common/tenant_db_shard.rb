class Common::TenantDbShard < CommonRecord
  has_many :db_connections, class_name: 'Common::TenantDbConnection', foreign_key: 'shard_id'

  class << self
    def shard_name(tenant_id)
      :"shard_tenant_#{tenant_id}"
    end

    def build_shards_config
      all_shards = all.includes(:db_connections).order(:tenant_id)
      all_shards
        .map(&:shard_name)
        .zip(all_shards.map(&:build_shard_config))
        .to_h
    end
  end

  def shard_name
    self.class.shard_name(tenant_id).to_sym
  end

  def build_shard_config
    db_connections
      .map(&:role)
      .map(&:to_sym)
      .zip(db_connections.map(&:build_connection_config))
      .to_h
  end
end
