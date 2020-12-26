Rails.application.routes.draw do
  root 'root#index'

  resources :asset_formation_calc do
    collection do
      post 'calculate'
    end
  end
end
