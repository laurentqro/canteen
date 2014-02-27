CantineApp::Application.routes.draw do
  resources :read_entries


  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :entries do 

  end

  resources :feeds
  resources :users
  resources :subscriptions
  resources :bookmarks

  root to: 'feeds#index'

  match 'feeds/:id', to: 'feeds#subscribe', as: :feeds_subscribe

  match 'entries/:id/bookmark', to: 'entries#bookmark', as: :entries_bookmark
  match 'entries/:id/mark_as_read', to: 'entries#mark_as_read', as: :entries_mark_as_read

  match 'tagged', to: 'subscriptions#tagged', :as => 'tagged'


end
