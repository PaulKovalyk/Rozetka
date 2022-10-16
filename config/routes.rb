Rails.application.routes.draw do
  get 'carts/new'
  get 'carts/show'
  get 'carts/create'
  devise_for :users
  resources :products
  resources :categories
  resources :orders
  resource :cart
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  post 'carts/add_product/:id', to: 'carts#add_product', as: 'add_product'
  post 'carts/remove_product/:id', to: 'carts#remove_product', as: 'remove_product'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  get '/delete_session_cart', to: 'products#delete_session_cart', via: [:destroy]
  get '/empty_cart', to: 'carts#empty_cart', via: [:destroy]
  delete 'products/destroy_for_session/:id', to: 'products#destroy_for_session', as: 'destroy_for_session'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
end
