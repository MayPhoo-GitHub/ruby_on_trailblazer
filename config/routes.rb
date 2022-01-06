# frozen_string_literal: true

Rails.application.routes.draw do
  root 'login#login'
  get '/login', to: 'login#login'
  post '/login', to: 'login#action_login'
  get '/logout', to: 'login#logout'
  # for posts
  resources :posts do
    collection do
      get :new_post, to: 'posts#new'
      post :new_post, to: 'posts#create'

    end
    member do
      get :edit
      put :edit, to: 'posts#update'
    end
  end

  # for users
  resources :users do
    collection do
      get :new_user, to: 'users#new'
      post :new_user, to: 'users#create'
    end
    member do
      get :edit
      put :edit, to: 'users#update'
    end
  end

end
