Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles, :users, :categories
  root 'pages#home'
  get 'pages/about', to: 'pages#about'
  get 'sign_up', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
