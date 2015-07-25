Rails.application.routes.draw do
  root to: "static_pages#index"
  
  get 'static_pages/start', to: 'static_pages#start'
  resources :users, only: [:new, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]
end
