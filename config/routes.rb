Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'lists/index'
  get 'lists/show'
  post '/shopping', to: "order_details#create"
  resources :order_details
  resource :cart, only: :show
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'products#index'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :customers
  resources :lists
  resources :products
  resources :reviews, only: %i(create update)
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
