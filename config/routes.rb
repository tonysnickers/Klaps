Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#dashboard'
  get 'dashboard/index', to: 'dashboards#index', as: :dashboard_index

  resources :group, only: [:new] do
    resources :ordered_choices, only: %i[new edit]
    resources :quizz_choices, only: %i[new edit]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
