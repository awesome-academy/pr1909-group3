# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'

  get 'set_language/en'
  get 'set_language/vi'

  resources :votes, only: %i[create index]
  resources :polls
  resources :notes
  resources :questions
  resources :participants, only: %i[edit update]
  resources :answers
  resources :events do
    collection do
      post :join_by_code
      post :checkout_event
    end

    member do
      get :polls
      get :questions
      get :notes
      get :documents
      get :my_questions
    end

    resource :questions
  end

  devise_for :users, path: '',
  path_names: {
    sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration',
    confirmation: 'confirmation',
  }, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  root 'home#index'

  namespace :dashboard do
    resources :events do
      resources :notes do
        member  do
          post :change_status
        end
      end
      resources :polls do
        member  do
          post :change_status
          post :lock_vote
        end
      end
      resources :questions do
        member  do
          post :change_status
          post :lock_answer
        end
      end

      resources :invitations do
        collection do
          post :invite_by_contact
          post :import
          get :list_invited
        end
      end
      resources :participants do
        collection do
          get :admin_list
          post :set_admin
        end
      end
      resources :documents

      collection do
        get :invited
      end
    end
    resources :contacts do
      collection do
        post :import
      end
    end

    root 'home#index'
  end

  resources :invitation_confirmations, only: [:edit]
end
