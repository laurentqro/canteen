CantineApp::Application.routes.draw do

  root to: 'feeds#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :entries
  resources :read_entries
  resources :feeds
  resources :users
  resources :subscriptions
  resources :bookmarks

  post 'feeds/:id', to: 'feeds#subscribe', as: :feeds_subscribe

  get 'entries/:id/bookmark', to: 'entries#bookmark', as: :entries_bookmark
  get 'entries/:id/mark_as_read', to: 'entries#mark_as_read', as: :entries_mark_as_read
  get 'feeds/:id/update_entries', to: 'feeds#update_entries', as: :feeds_update_entries

  get 'tagged', to: 'subscriptions#tagged', :as => 'tagged'

  resources :entries do
  get 'page/:page', action: :index, on: :collection
  end

end
