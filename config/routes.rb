Rails.application.routes.draw do

  root 'pages#index'
  resources :tasks
  resources :users
  #friend routing
  resources :friend_requests
  resources :friends, only: [:index, :destroy]
# listing all tasks and current user tasks
  get '/users/index' => 'users#index'
  get '/usertasks' => 'tasks#listuser'

  get 'pages/help'
  get 'pages/contact'

# these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'


end
