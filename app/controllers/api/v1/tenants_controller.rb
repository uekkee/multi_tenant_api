class Api::V1::TenantsController < CommonController
  def index
    render json: { tenants: Common::Tenant.all }
  end
end
