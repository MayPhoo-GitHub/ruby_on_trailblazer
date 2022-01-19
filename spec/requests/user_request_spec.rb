require "rails_helper"

RSpec.describe "User", :type => :request do
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
                       email: "superuser1@gmail.com",
                       password: "fakepassword",
                     } }
      expect(subject).to redirect_to(login_path)
    end
    scenario "valid login" do
      post "/login", params: { :user => {
                       email: "superuser1@gmail.com",
                       password: "superuser1@gmail.com1",
                     } }
      expect(response.status).to eq(302)
    end
  end
  # user index page
  describe "GET /users" do
    scenario "User List" do
      get "/users"
      expect(response.status).to eq(302)
    end
  end
  # user create
  describe "POST users/new_user" do
    scenario "User Create" do
      post "/users/new_user", params: { :user => user_params }
      user = User.last
      expect(user.name).to eq("test user")
      expect(user.email).to eq("test@gmail.com")
    end
  end

  # user update
  describe "POST users/:id/edit" do
    scenario "user edit" do
      last_user_id = User.last.id
      put "/users/#{last_user_id}/edit", params: { user: user_params }
      updated_user = User.find(last_user_id)
      expect(updated_user.name).to eq("test user")
      expect(updated_user.email).to eq("test@gmail.com")
    end
  end
end
