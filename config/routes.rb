Rails.application.routes.draw do
  get 'sessions/new'
  resources :pictures do
    post :confirm, on: :collection
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:new, :create, :show]
end
