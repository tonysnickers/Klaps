Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index'

  resources :groups, only: %i[index show new create update] do
    resources :ordered_choices, only: %i[new edit]
    resources :quizz_choices, only: %i[new create]
  end
  resources :group_users, only: [:create]

  resources :quizz_choices, only: %i[index edit] do
    member do
      patch :add_actor
      patch :add_duration
      patch :add_date
      patch :add_keyword
    end
  end
end
