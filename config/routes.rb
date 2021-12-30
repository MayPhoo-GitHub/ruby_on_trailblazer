Rails.application.routes.draw do
  root "login#login"
  # posts
  resources :posts do
    collection do
      get :new_post, to: "posts#new"
      post :new_post
      get :search
      get :filter
      get :download_csv
      get :csv_format
      get :upload_csv
      post :import_csv
      get :csv_format
    end
    member do
      get :edit
      put :edit, to: "posts#update"
    end
  end

  # users
  resources :users do
    collection do
      get :new_user, to: "users#new"
      post :new_user
      get :profile
      get :edit_profile
      put :edit_profile, to: "users#update_profile"
      get :edit_password
      put :edit_password, to: "users#change_password"
    end
    member do
      get :edit
      put :edit, to: "users#update"
    end
  end

  # login
  get "/login", to: "login#login"
  post "/login", to: "login#actionLogin"
  get "/logout", to: "login#logout"

  get "/password/reset", to: "password_resets#new"
  post "/password/reset", to: "password_resets#create"
  get "/password/reset/edit", to: "password_resets#edit"
  patch "/password/reset/edit", to: "password_resets#update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
