SuchCoinWow::Application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  resource :dashboard, only: [ :index ]
  resources :coins do
    post 'sync', on: :member
    get 'daily_summary', on: :member
  end

  resources :transactions

  root to: 'dashboard#index'
end
