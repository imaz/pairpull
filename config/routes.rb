Pairpull::Application.routes.draw do
  devise_for :users
  root :to => 'root#index'

  resources :users, only: [:show]
  resources :team_requests, only: [:create] do
    member do
      post 'accept'
      post 'reject'
    end
  end
  post 'team_requests/accept'
  post 'team_requests/reject'
  resources :teams, only: [:show] do
    get 'wishes/pull'
    resources :wishes, only: [:create]
  end

end
