require "rails_helper"

RSpec.describe UsersController, type: :controller do
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
  # function :index
  describe "GET users#index" do
    it "get all users" do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # function :create
  describe "User users#create" do
    context "valid user param" do
      it "create users" do
        post :create, params: { :user => user_params }
        user = User.last
        expect(user.name).to eq("May Phoo Wai")
        expect(user.email).to eq("admin@gmail.com")
      end
    end
    context "invalid post param" do
      it "create users" do
        user_params[:name] = nil
        post :create, params: { :user => user_params }
        expect(assigns(:form).errors[:name][0]).to eq "can't be blank"
        expect(response).to render_template(:new)
      end
    end
  end

  # function :show
  describe "GET users#show" do
    it "show user detail" do
      last_user = User.last
      get :show, params: { :id => last_user.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(assigns(:user)).not_to be_nil
      expect(assigns(:user).name).to eq last_user.name
    end
  end

  #   # function :update
  #   describe "PUT posts#update" do
  #     context "valid post param" do
  #       it "update post" do
  #         last_post = Post.last
  #         put :update, params: { :post => post_params, :id => last_post.id }
  #         expect(assigns(:model).title).to eq "lorem test2"
  #       end
  #     end
  #     context "invalid post param" do
  #       it "update post" do
  #         last_post = Post.last
  #         post_params[:title] = nil
  #         put :update, params: { :post => post_params, :id => last_post.id }
  #         expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
  #         expect(response).to render_template(:edit)
  #       end
  #     end
  #   end

  #   # function :destroy
  #   describe "DELETE posts#destroy" do
  #     it "delete post" do
  #       post = Post.create! post_params
  #       expect {
  #         delete :destroy, params: { :id => post.id }
  #       }.to change(Post, :count).by(-1)
  #     end
  #   end
end
