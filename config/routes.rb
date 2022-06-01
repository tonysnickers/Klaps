Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index'

  resources :groups, only: %i[index show new create update] do
    resources :ordered_choices, only: %i[new edit]
    resources :quizz_choices, only: %i[new create]
  end
  resources :quizz_choices, only: %i[edit]
end
