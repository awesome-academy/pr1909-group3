Rails.application.routes.draw do
  devise_for :users, path: '',
                     path_names: {
                       sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration',
                       confirmation: 'confirmation',
                     }, controllers: {
                       registrations: "users/registrations",
                       sessions: "users/sessions", omniauth_callbacks: 'omniauth_callbacks',
                     }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :events do
    collection do
      post :join_by_code
    end
  end

  root "homes#index"
end
