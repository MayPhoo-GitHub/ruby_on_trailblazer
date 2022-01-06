# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authorized?
  # show all posts
  def index
    run Post::Operation::Index,current_user: current_user
    @posts = result[:model].paginate(page: params[:page], per_page: 5)
  end

  def filter
    run Post::Operation::Filter(user_id: user[:id])
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
    run Post::Operation::Create, current_user: current_user  do |_|
      return redirect_to posts_path
    end
    render :new
  end

  # function: edit
  # show post edit form
  # params: id
  def edit
    run Post::Operation::Update::Present 
  end

  # function: update
  # update user
  # params: user, id
  def update
    run Post::Operation::Update,current_user: current_user do |result|
      return redirect_to post_path(result[:model])
    end
    render :edit
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
