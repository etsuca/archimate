Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  
  get 'welcome', to: 'static_pages#welcome'
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'login', to: 'sessions#new'
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/logout", to: "sessions#destroy"

  resources :architecture
  resources :likes, only: %i[index create destroy]
  resource :profile, only: %i[show edit update destroy]
  resources :password_resets, only: %i[new create edit update]
  resources :diagnosis, only: %i[new index]
end
