Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :categories
  resources :orders
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  get '/delete_session_cart', to: 'products#delete_session_cart', via: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
end
