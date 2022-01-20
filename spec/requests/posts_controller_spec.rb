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
  describe "GET posts#index" do
    it "get all posts" do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # function :create
  describe "POST posts#create" do
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
  describe "PUT posts#update" do
    context "valid post param" do
      it "update post" do
        last_post = Post.last
        put :update, params: { :post => post_params, :id => last_post.id }
        expect(assigns(:model).title).to eq "lorem test2"
      end
    end
    context "invalid post param" do
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
  describe "DELETE posts#destroy" do
    it "delete post" do
      post = Post.create! post_params
      expect {
        delete :destroy, params: { :id => post.id }
      }.to change(Post, :count).by(-1)
    end
  end

  # function :filter
  describe "GET post#filter" do
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

  # function :export
  describe "GET posts#export" do
    it "export post list csv" do
      Post.create! post_params
      get :download_csv, format: :csv
      expect(response.header["Content-Type"]).to include "text/csv"
      expect(response.body).to include("lorem test2")
    end
  end
  # function :action_import
  describe "POST posts#action_import" do
    it "import valid csv file from temp folder" do
      initial_post_count = Post.count
      post :import_csv, params: { :file => fixture_file_upload("#{Rails.root}/tmp/rspec/test.csv", "text/csv") }
      post = Post.last
      final_post_count = Post.count
      expect(post.title).to eq("lorem test2")
      expect(post.description).to eq("lorem test lorem test")
    end

    it "import invalid csv file from temp folder" do
      post :import_csv, params: { :file => fixture_file_upload("#{Rails.root}/tmp/rspec/error.csv", "text/csv") }
      expect(assigns(:form).errors[:file][0]).to eq "The header is wrong! Please dowload csv_format first"
    end
  end

  describe "POST posts#action_import" do
    it "create valid temp csv file and use it to test action_import" do
      csv_rows = <<~EOS
        title,description,public_flag
        csv test title1, csv test description1, 1
        csv test title2, csv test description2, 0
        csv test title3, csv test description3, 1
      EOS
      file = Tempfile.new("post_list.csv")
      file.write(csv_rows)
      file.rewind
      expect {
        post :import_csv, params: { :file => Rack::Test::UploadedFile.new(file, "text/csv") }
      }.to change(Post, :count).by(3)
    end

    it "create invalid temp csv file and use it to test action_import" do
      csv_rows = <<~EOS
        title,description
        csv test title1, csv test description1, 1
        csv test title2, csv test description2, 0
        csv test title3, csv test description3, 1
      EOS
      file = Tempfile.new("post_list.csv")
      file.write(csv_rows)
      file.rewind
      post :import_csv, params: { :file => Rack::Test::UploadedFile.new(file, "text/csv") }
      expect(assigns(:form).errors[:file][0]).to eq "The header is wrong! Please dowload csv_format first"
    end
  end
end
