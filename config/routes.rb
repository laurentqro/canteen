CantineApp::Application.routes.draw do
  devise_for :users

  resources :entries
  resources :feeds
  resources :users
  resources :subscriptions
  resources :bookmarks

  root to: 'feeds#index'

  match 'feeds/:id', to: 'feeds#subscribe', as: :feeds_subscribe


end
