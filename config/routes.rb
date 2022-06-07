Rails.application.routes.draw do
  get 'movie_seens/index'
  get 'wishes/index'
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index'

  resources :groups, only: %i[index show new create update results] do
    resources :quizz_choices, only: %i[new create index]
    resources :movies, only: %i[index]

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


  resources :movie_seens, only: [:new, :create, :index]
  resources :wishes, only: [:new, :create, :index]



  resources :quizz_choices, only: %i[edit] do
    member do
      patch :add_genre
      patch :add_keyword
      patch :add_duration
      patch :add_date
      patch :add_actor
      patch :change_step
      patch :validate
    end
  end
end
