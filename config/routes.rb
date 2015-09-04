Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root to: "static_pages#index"
  
  get 'static_pages/start', to: 'static_pages#start'
  resources :users, only: [:new, :create]

  namespace :api, constraints: { formats: [ :json ] }  do
    resources :boards, except: [:new, :edit]
  end

  resource :session, only: [:new, :create, :destroy]
end
