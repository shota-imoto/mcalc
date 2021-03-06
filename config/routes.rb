Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root 'root#index'
      resources :config, only: [:new, :create]
      resources :retirement_asset_config, only: [:new, :create]
      namespace :users do
        resources :sign_up, only: :create do
          collection do
            get :confirm
          end
        end
        resources :sign_in, only: :create
        resource :password, only: [:edit, :update] do
          collection do
            patch :reset
            get :confirm
            patch :reissue
          end
        end
      end
    end
  end
end
