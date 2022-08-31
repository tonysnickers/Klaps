Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index'
  get 'favorites/new'
  post 'wishes', to: 'wishes#add'

  resources :groups, only: %i[index show new create update results] do
    resources :quizz_choices, only: %i[new create index]
    resources :movies, only: %i[index]
    resources :wishes, only: %i[create]

    member do
      post :compute_results
      get :results
    end
  end

  resources :group_users, only: %i[create update]
  resources :group_users, only: %i[edit] do
    member do
      get :movie_order
      patch :movie_order
    end
  end

  resources :friends, only: %i[index new create destroy]
  resources :movie_seens, only: %i[create index]
  resources :wishes, only: %i[index new destroy]
  resources :favorites, only: %i[index new create destroy] do
    member do
      get :friendsfav
    end
  end

  resources :quizz_choices, only: %i[edit] do
    member do
      patch :edit_genre
      patch :add_keyword
      patch :add_duration
      patch :add_date
      patch :add_actor
      patch :change_step
      patch :validate
    end
  end
end
