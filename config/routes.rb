Rails.application.routes.draw do
  get 'lists/index'
  get 'lists/show'
  post "/shopping", to: "carts#shopping"
  get "/carts", to: "carts#show"
  delete "/carts", to: "carts#destroy"
  patch "/carts", to: "carts#update"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'products#index'
  devise_for :users
  resources :customers
  resources :lists
  resources :products
  resources :orders
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
