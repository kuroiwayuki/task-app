Rails.application.routes.draw do
  get 'tasks/index'

  get "search" => "searches#search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'tasks#index'
  resources :tasks
end
