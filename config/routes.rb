SuchCoinWow::Application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end
end
