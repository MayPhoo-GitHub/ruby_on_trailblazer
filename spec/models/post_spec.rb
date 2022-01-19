require "rails_helper"

RSpec.describe Post, type: :model do
  context "validation tests" do
    it "ensures title presence" do
      post = Post.new(description: "lorem test lorem test lorem test", public_flag: "true", created_user_id: "7").save
      expect(post).to eq (false)
    end
    it "ensures description presence" do
      post = Post.new(title: "lorem test2", public_flag: "true", created_user_id: "7").save
      expect(post).to eq (false)
    end
    it "ensures public_flag presence" do
      post = Post.new(title: "lorem test2", description: "lorem test lorem test lorem test", created_user_id: "7").save
      expect(post).to eq (false)
    end
    it "ensures created_user_id presence" do
      post = Post.new(title: "lorem test2", description: "lorem test lorem test lorem test", public_flag: "true").save
      expect(post).to eq (false)
    end
    it "should save successfully" do
      post = Post.new(title: "lorem test2", description: "lorem test lorem test lorem test", public_flag: "true", created_user_id: "7").save
      expect(post).to eq (true)
    end
  end
end
