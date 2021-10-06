class Api::V1::Tenants::UsersController < TenantedController
  def index
    render json: { users: Tenant::User.all }
  end

  def create
    Tenant::User.create! save_params
  end

  private

  def save_params
    params.permit(:name, :email)
  end

end
