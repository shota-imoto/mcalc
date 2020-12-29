Rails.application.routes.draw do
  root 'root#index'

  resources :asset_formation_calc do
    collection do
      post 'calculate'
    end
  end

  resources :asset_config, only: [:new, :create, :edit, :update]
  resources :retirement_asset_calc, only: [:new, :create, :edit, :update]
end
