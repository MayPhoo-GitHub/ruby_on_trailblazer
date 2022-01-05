# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  # for posts
  resources :posts do
    collection do
    end
    member do
    end
  end

  # for users
  resources :users do
    collection do
    end
    member do
    end
  end

end
