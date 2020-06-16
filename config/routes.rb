Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, path: '',
                       # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
                       path_names: {
                         sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration',
                         confirmation: 'confirmation',
                       }, controllers: {
                         registrations: "users/registrations",
                         sessions: "users/sessions", omniauth_callbacks: 'omniauth_callbacks',
                       }

    resources :events do
      collection do
        post :join_by_code
      end
    end

    root "homes#index"
    get '/dashboard', to: 'dashboard#index'
  end
end
