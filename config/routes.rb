Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations', sessions: 'users/sessions' }
  root 'root#index'

  resources :asset_formation_calc do
    collection do
      post 'calculate'
    end
  end

  resources :asset_config, only: [:new, :create, :edit, :update]
  resources :retirement_asset_calc, only: [:new, :create, :edit, :update]
  resources :yield_config, only: [:new, :create, :edit, :update]

  # api
  namespace :api do
    namespace :v1 do
      root 'root#index'
      devise_for :users, controllers: { registrations: 'api/v1/users/registrations', confirmations: 'api/v1/users/confirmations', sessions: 'api/v1/users/sessions' }
      resources :config, only: [:new, :create]
      resources :retirement_asset_config, only: [:new, :create]
      namespace :users do
        resources :sign_up, only: :create
        resources :sign_in, only: :create
      end
    end
  end
end
