# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized?
  # show all users
  def index
    run User::Operation::Index
  end

  # function: show
  # show user details
  def show
    run User::Operation::Show::Present do |result|
      @user = result[:model]
      run Post::Operation::Filter,user_id: @user.id do |result|
      @posts = result[:model].paginate(page: params[:page], per_page: 5)
      end
    end
  end

  # function: new
  # show user create form
  def new
    run User::Operation::Create::Present
  end

  # function: create
  # create user
  # params: user param
  def create
    run User::Operation::Create do |_|
      return redirect_to users_path,notice: :USER_CREATED
    end
    render :new
  end 

  # function: edit
  # show user edit form
  # params: id
  def edit
    run User::Operation::Update::Present 
  end

  # function: update
  # update user
  # params: user, id
  def update
    run User::Operation::Update do |result|
      return redirect_to user_path(result[:model]),notice: :USER_UPDATED
    end
    render :edit
  end

  # function: destroy
  # destroy user
  # params: id
  def destroy
    run User::Operation::Destroy do |_|
      return redirect_to users_path,notice: :USER_DELETED
    end
  end

end
