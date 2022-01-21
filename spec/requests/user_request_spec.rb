require "rails_helper"
RSpec.describe "User", :type => :request do
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }
  let(:user_params) {
    {
      name: "test user",
      email: "test@gmail.com",
      password: "rtesting",
      password_confirmation: "rtesting",
      super_user_flag: true,
      phone: "09401245003",
      address: "Yangon",
      birthday: "1998-9-3",
    }
  }
  # user login
  describe "User Login" do
    scenario "invalid login" do
      post "/login", params: { :user => {
                       email: "test@gmail.com",
                       password: "wrongpassword",
                     } }
      expect(subject).to redirect_to(login_path)
    end
    scenario "valid login" do
      post "/login", params: { :user => {
                       email: "admin@gmail.com",
                       password: "mayphoowai",
                     } }
      expect(subject).to redirect_to(posts_path)
    end
  end
  # user index page
  describe "GET /users" do
    scenario "User List" do
      get "/users"
      expect(response.status).to eq(200)
    end
  end
  # user create
  describe "POST users/new_user" do
    scenario "User Create" do
      post "/users/new_user", params: { :user => user_params }
      user = User.last
      expect(user.name).to eq("May Phoo Wai")
      expect(user.email).to eq("admin@gmail.com")
    end
  end

  # show user detail
  describe "GET users/show" do
    scenario "User Detail" do
      user = User.create(user_params)
      get user_path(user)
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end
  
  # user edit
  describe "POST users/:id/edit" do
    scenario "valid user edit" do
      last_user_id = User.last.id
      put "/users/#{last_user_id}/edit", params: { user: user_params }
      updated_user = User.find(last_user_id)
      expect(updated_user.name).to eq("May Phoo Wai")
      expect(updated_user.email).to eq("admin@gmail.com")
    end

    scenario "invalid user edit" do
      last_user_id = User.last.id
      user_params[:email] = "test@gmail.com"
      put "/users/#{last_user_id}/edit", params: { user: user_params }
      updated_user = User.find(last_user_id)
      expect(updated_user.name).not_to eq("test1 user")
      expect(response).to render_template(:edit)
    end
  end
  # delete user
  describe "DELETE users/:id" do
    scenario "delete user" do
      user = User.create! user_params
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
    end
  end
  # profile edit
  describe "PUT users/edit_profile" do
    scenario "edit profile" do
      put "/users/edit_profile", params: { user: user_params }
      expect(response.status).to eq(200)
    end
  end
end
