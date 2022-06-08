Rails.application.routes.draw do
  root to: 'rooms#home'
  get 'rooms', to: 'rooms#home'
  get '/reservations/:id', to: 'rooms#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :rooms, :only => [:new, :create, :show, :edit, :update, :destroy]
  resources :users, :only => [:show, :edit, :update]
  resources :reservations, :only => [:new, :create, :edit, :update, :destroy]

  get 'search', to: 'rooms#search'
  get '/users/:id/account', to: 'users#account'
  get '/users/:id/posts', to: 'users#posts'
  get '/users/:id/reservations', to: 'users#reservations'
end
