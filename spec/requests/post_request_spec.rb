require "rails_helper"
RSpec.describe "Post", :type => :request do
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }
  let(:post_params) {
    {
      title: "lorem test2",
      description: "lorem test lorem test lorem test",
      public_flag: true,
      created_user_id: 7,
    }
  }
  # post index
  describe "/posts" do
    scenario "get post list" do
      get "/posts"
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # post create
  describe "/posts/new_post" do
    scenario "post create" do
      post "/posts/new_post", params: { :post => post_params }
      post = Post.last
      expect(post.title).to eq("lorem test2")
      expect(post.description).to eq("lorem test lorem test lorem test")
    end
  end
  # post detail
  describe "/posts/show" do
    scenario "post detail" do
      post = Post.create(post_params)
      get post_path(post)
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end
  # post update
  describe "posts/edit" do
    scenario "valid post update" do
      last_post_id = Post.last.id
      put "/posts/#{last_post_id}/edit", params: { post: post_params }
      updated_post = Post.find(last_post_id)
      expect(updated_post.title).to eq("lorem test2")
      expect(updated_post.description).to eq("lorem test lorem test lorem test")
    end

    scenario "invalid post update" do
      post_params[:title] = nil
      last_post_id = Post.last.id
      put "/posts/#{last_post_id}/edit", params: { post: post_params }
      updated_post = Post.find(last_post_id)
      expect(updated_post.title).not_to eq("lorem test1")
      expect(response).to render_template(:edit)
    end
  end
  # post delete
  describe "posts/:id" do
    scenario "delete post" do
      post = Post.create! post_params
      expect {
        delete post_path(post)
      }.to change(Post, :count).by(-1)
    end
  end
end
