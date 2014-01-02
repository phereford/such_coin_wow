SuchCoinWow::Application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  get '/dashboard', to: 'dashboard#index', as: :dashboard
  resources :coins do
    post 'sync', on: :member
    get 'daily_summary', on: :member
  end

  resources :transactions

  root to: 'dashboard#index'
end
