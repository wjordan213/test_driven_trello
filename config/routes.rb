Rails.application.routes.draw do
  root to: "static_pages#index"
  
  get 'static_pages/start', to: 'static_pages#start'
  resources :users, only: [:new, :create]

  namespace :api, defaults: { format: :json }  do
    resources :boards
  end

  resource :session, only: [:new, :create, :destroy]
end
