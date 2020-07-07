Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"

  get "set_language/en"
  get "set_language/vi"

  devise_for :users, path: '',
                     path_names: {
                       sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration',
                       confirmation: 'confirmation',
                     }, controllers: {
                       registrations: "users/registrations",
                       sessions: "users/sessions", omniauth_callbacks: 'omniauth_callbacks',
                     }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :notes
  resources :questions
  resources :participants, only: %i(edit update)
  resources :answers

  resources :events do
    collection do
      post :join_by_code
      post :checkout_event
    end

    member do
      get :questions
      get :notes
      get :my_questions
    end

    resources :questions
  end

  root "home#index"

  namespace :dashboard do
    resources :events do
      resources :notes do
        member do
          post :change_status
        end
      end

      resources :questions do
        member  do
          post :change_status
          post :lock_answer
        end
      end

      resources :participants do
        collection do
          get :admin_list
          post :set_admin
        end
      end

      resources :invitations do
      end
    end

    root 'home#index'
  end
end
