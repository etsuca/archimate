Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  
  get 'welcome', to: 'static_pages#welcome'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :architecture do
    collection do
      get :random
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
  resource :profile, only: %i[show edit update destroy]
  resources :password_resets, only: %i[new create edit update]
end
