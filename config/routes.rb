Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index'

  resources :groups, only: %i[index show new create update results] do
    resources :quizz_choices, only: %i[new create index]
    resources :movies, only: %i[index]
    member do
      patch :results
    end
  end

  resources :group_users, only: %i[create update]
  resources :group_users, only: %i[edit] do
    member do
      get :movie_order
      patch :movie_order
    end
  end

  resources :quizz_choices, only: %i[edit] do
    member do
      patch :add_actor
      patch :add_duration
      patch :add_date
      patch :add_keyword
      patch :change_step
    end
  end
end
