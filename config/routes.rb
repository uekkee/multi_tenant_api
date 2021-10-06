Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :tenants, only: :index do
        resources :users, only: %i[index create], module: :tenants
      end
    end
  end
end
