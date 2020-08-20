Rails.application.routes.draw do
  root 'users#new'
  resources :contacts
  resources :pictures do
    post :confirm, on: :collection
    patch :confirm, on: :member
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
  resources :users do
    post :confirm, on: :collection
    patch :confirm, on: :member
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
