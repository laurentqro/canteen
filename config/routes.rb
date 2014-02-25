CantineApp::Application.routes.draw do
  devise_for :users

  resources :entries
  resources :feeds
  resources :users
  resources :subscriptions
  resources :bookmarks

  root to: 'feeds#index'

  match 'feeds/:id', to: 'feeds#subscribe', as: :feeds_subscribe

  match 'entries/:id', to: 'entries#bookmark', as: :entries_bookmark

  match 'tagged', to: 'subscriptions#tagged', :as => 'tagged'


end
