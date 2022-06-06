Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index'

  resources :groups, only: %i[index show new create update] do
    resources :quizz_choices, only: %i[new create index]
    resources :movies, only: %i[ index ]
  end
  resources :group_users, only: [:create]

  resources :quizz_choices, only: %i[edit] do
    member do
      patch :add_actor
      patch :add_duration
      patch :add_date
      patch :add_keyword
      patch :change_step
      patch :validate
    end
  end
end
