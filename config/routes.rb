Rails.application.routes.draw do
  resources :pictures do
    post :confirm, on: :collection
  end
end
