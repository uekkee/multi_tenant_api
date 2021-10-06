class TenantRecord < ApplicationRecord
  self.abstract_class = true

  connects_to shards: {
    shard_tenant_1: {
      writing:
        {
          "adapter"=>"postgresql",
          "encoding"=>"unicode",
          "pool"=>5,
          "host"=>"127.0.0.1",
          "username"=>"postgres",
          "password"=>nil,
          "database"=>"multi_tenant_api_tenant_1_development"
        },
      reading:
        {"adapter"=>"postgresql",
         "encoding"=>"unicode",
         "pool"=>5,
         "host"=>"127.0.0.1",
         "username"=>"postgres",
         "password"=>nil,
         "database"=>"multi_tenant_api_tenant_1_development"
        },
    },
    shard_tenant_2: {
      writing:
        {
          "adapter"=>"postgresql",
          "encoding"=>"unicode",
          "pool"=>5,
          "host"=>"127.0.0.1",
          "username"=>"postgres",
          "password"=>nil,
          "database"=>"multi_tenant_api_tenant_2_development"
        },
      reading:
        {"adapter"=>"postgresql",
         "encoding"=>"unicode",
         "pool"=>5,
         "host"=>"127.0.0.1",
         "username"=>"postgres",
         "password"=>nil,
         "database"=>"multi_tenant_api_tenant_2_development"
        },
    },
  }
end
