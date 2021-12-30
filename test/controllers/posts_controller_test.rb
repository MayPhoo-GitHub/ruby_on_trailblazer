class PostsController < ApplicationController
  
  # function : index
  # @return [<Type>] <posts>
  def index
    @posts = PostService.getAllPosts()
  end
end
