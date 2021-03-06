require "rails_helper"

RSpec.describe PostsController, type: :controller do
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }

  let(:post_params) {
    {
      title: "lorem test2",
      description: "lorem test lorem test lorem test",
      public_flag: true,
      created_user_id: 7,
    }
  }
  # function :index
  describe "posts#index" do
    it "get all posts" do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # function :create
  describe "posts#create" do
    context "valid post param" do
      it "create posts" do
        post :create, params: { :post => post_params }
        post = Post.last
        expect(post.title).to eq("lorem test2")
        expect(post.description).to eq("lorem test lorem test lorem test")
        expect(response).to redirect_to(posts_path)
        expect(response.content_type).to eq "text/html; charset=utf-8"
      end
    end
    context "invalid post param" do
      it "create posts" do
        post_params[:title] = nil
        post :create, params: { :post => post_params }
        expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
        expect(response).to render_template(:new)
      end
    end
  end

  # function :show
  describe "GET posts#show" do
    it "show post detail" do
      last_post = Post.last
      get :show, params: { :id => last_post.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(assigns(:post)).not_to be_nil
      expect(assigns(:post).title).to eq last_post.title
    end
  end

  # function :update
  describe "posts#update" do
    context "valid post update" do
      it "update post" do
        last_post = Post.last
        put :update, params: { :post => post_params, :id => last_post.id }
        expect(assigns(:model).title).to eq "lorem test2"
      end
    end
    context "invalid post update" do
      it "update post" do
        last_post = Post.last
        post_params[:title] = nil
        put :update, params: { :post => post_params, :id => last_post.id }
        expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
        expect(response).to render_template(:edit)
      end
    end
  end

  # function :destroy
  describe "posts#destroy" do
    it "delete post" do
      post = Post.create! post_params
      expect {
        delete :destroy, params: { :id => post.id }
      }.to change(Post, :count).by(-1)
    end
  end

  # function :filter
  describe "post#filter" do
    it "get all posts" do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
    it "get own posts" do
      get :filter
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # function :search
  describe "post#search" do
    it "valid search" do
      get :search, params: { search_keyword: "lorem" }
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
    it "invalid search" do
      get :search, params: { search_keyword: "mayphoo" }

      expect(response.body).to eq("")
      expect(response).to render_template(:index)
    end
  end

  # function :export
  describe "posts#export" do
    it "export post list csv" do
      Post.create! post_params
      get :download_csv, format: :csv
      expect(response.header["Content-Type"]).to include "text/csv"
      expect(response.body).to include("lorem test2")
    end
  end
  # function :import
  describe "posts#import" do
    it "import valid csv file" do
      post :import_csv, params: { :file => fixture_file_upload("#{Rails.root}/tmp/rspec/test.csv", "text/csv") }
      post = Post.last
      expect(post.title).to eq("lorem test2")
      expect(post.description).to eq("lorem test lorem test")
    end

    it "import invalid csv file" do
      post :import_csv, params: { :file => fixture_file_upload("#{Rails.root}/tmp/rspec/error.csv", "text/csv") }
      expect(assigns(:form).errors[:file][0]).to eq "The header is wrong! Please dowload csv_format first"
    end
  end
end
