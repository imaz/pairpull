Pairpull::Application.routes.draw do
  devise_for :users
  root :to => 'root#index'

  resources :users, only: [:show]
  resources :team_requests, only: [:index, :create, :destroy]
  resources :teams, only: [:show] do
    get 'wishes/pull'
    resources :wishes, only: [:create]
  end

end
