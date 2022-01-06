# frozen_string_literal: true

class PostsController < ApplicationController

  # show all posts
  def index
    run Post::Operation::Index
    @posts = result[:model].paginate(page: params[:page], per_page: 5)
  end

  # function: show
  # show post detail
  # params: id
  def show
    run Post::Operation::Show::Present do |result|
      @post = result[:model]
    end
  end

  # function: new
  # show post create form
  def new
    run Post::Operation::Create::Present
  end

  # function: create
  # create post
  # params: post param
  def create
    run Post::Operation::Create do |_|
      return redirect_to posts_path
    end
    render :new
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
