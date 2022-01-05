# frozen_string_literal: true

class PostsController < ApplicationController
   # show all posts
  def index
    run Post::Operation::Index
  end

  # function: show
  # show post detail
  # params: id
  def show
    run Post::Operation::Show::Present do |result|
      @post = result[:model]
    end
  end

  # function: destroy
  # destroy post
  # params: id
  def destroy
    run Post::Operation::Destroy do |_|
      return redirect_to posts_path
    end
  end
end
