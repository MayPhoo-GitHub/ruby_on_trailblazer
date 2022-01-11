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
      get :filter
      get :search
      get :upload_csv
      post :import_csv
      get :csv_format
      get :download_csv
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
      get :profile
      get :edit_profile
      put :edit_profile, to: 'users#update_profile'
      get :edit_password
      put :edit_password, to: 'users#update_password'
    end
    member do
      get :edit
      put :edit, to: 'users#update'

    end
  end

end
