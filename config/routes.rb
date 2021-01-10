Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  root 'root#index'

  resources :asset_formation_calc do
    collection do
      post 'calculate'
    end
  end

  resources :asset_config, only: [:new, :create, :edit, :update]
  resources :retirement_asset_calc, only: [:new, :create, :edit, :update]
  resources :yield_config, only: [:new, :create, :edit, :update]
end
