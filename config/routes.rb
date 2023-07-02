Rails.application.routes.draw do
  authenticated :user do
    root 'static_pages#top', as: :authenticated_root
  end
  root 'static_pages#welcome'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get 'users', to: 'users/registrations#failure'
    get 'users/password', to: 'users/registrations#update_passwords'
  end
  
  get 'welcome', to: 'static_pages#welcome'
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  resources :architecture
  resources :likes, only: %i[index create destroy]
  resource :user, only: %i[show]
  resources :diagnosis, only: %i[new index]
end
