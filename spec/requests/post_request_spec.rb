require "rails_helper"
RSpec.describe "Post", :type => :request do
  let(:post_params) {
    {
      title: "lorem test2",
      description: "lorem test lorem test lorem test",
      public_flag: true,
      created_user_id: 7,
    }
  }

  # post create
  describe "POST /posts/new_post" do
    scenario "post create" do
      post "/posts/new_post", params: { :post => post_params }
      post = Post.last
      expect(post.title).to eq("lorem test2")
      expect(post.description).to eq("lorem test lorem test lorem test")
    end
  end

  # post update
  describe "PUT posts/edit" do
    scenario "post update" do
      last_post_id = Post.last.id
      put "/posts/#{last_post_id}/edit", params: { post: post_params }
      updated_post = Post.find(last_post_id)
      expect(updated_post.title).to eq("lorem test2")
      expect(updated_post.description).to eq("lorem test lorem test lorem test")
    end
  end
end
