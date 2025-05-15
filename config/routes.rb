Rails.application.routes.draw do
  get 'tasks/index'

  get 'search' => 'searches#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'tasks#index'
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :tasks do
    member do
      patch :status_update
    end
    collection do
      get :modal  # <= これを追加
    end
  end
  
end
