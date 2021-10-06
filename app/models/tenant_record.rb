class TenantRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :tenant_1, reading: :tenant_1 }
end
