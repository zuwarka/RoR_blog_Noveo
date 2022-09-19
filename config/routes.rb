Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users

  root 'pages#index'
  get 'about', to: 'pages#about'

  resources :articles
  get 'signup', to: 'users#new'
  get 'update', to: 'users#edit'

  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :articles
    end
  end
end
