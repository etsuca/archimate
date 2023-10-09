Rails.application.routes.draw do
  authenticated :user do
    root 'static_pages#top', as: :authenticated_root
  end
  root 'static_pages#welcome'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get 'users', to: 'users/registrations#failure'
    get 'users/password', to: 'users/registrations#update_passwords'
    post 'users/guest_login', to: 'users/sessions#guest_login'
    get 'registrations/edit_password', to: 'users/registrations#edit_password'
    put 'registrations/update_password', to: 'users/registrations#update_password'
    get 'registrations/update_password', to: 'users/registrations#failure'
  end

  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'users_architecture', to: 'json_data#users_architecture'

  resources :architecture do
    collection do
      get :check_in
    end
  end
  resources :likes, only: %i[index create destroy]
  resource :user, only: %i[show]
  resources :diagnosis, only: %i[new index]
end
