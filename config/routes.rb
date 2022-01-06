# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  # for posts
  resources :posts do
    collection do
      get :new_post, to: 'posts#new'
      post :new_post, to: 'posts#create'

    end
    member do
    end
  end

  # for users
  resources :users do
    collection do
      get :new_user, to: 'users#new'
      post :new_user, to: 'users#create'
    end
    member do
    end
  end

end
