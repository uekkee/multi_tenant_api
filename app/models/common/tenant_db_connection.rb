class Common::TenantDbConnection < CommonRecord
  enum role: { writing: 1, reading: 2 }

  def create_tenant_db_if_not_exists
    query = "CREATE DATABASE #{database} ENCODING = '#{encoding}'"
    begin
      ActiveRecord::Base.connection.execute(query)
    rescue ActiveRecord::DatabaseAlreadyExists
      logger.info("PartnerDB already exists: #{database}")
    end
  end

  def build_connection_config
    attributes
      .slice(*%w[adapter encoding pool host username password database])
  end
end
