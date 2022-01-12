# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authorized?
  # show all posts
  def index
    run Post::Operation::Index, current_user: current_user
    @posts = result[:model].paginate(page: params[:page], per_page: 5)
  end

  # function: filter
  # show filter post
  # params: id
  def filter
    run Post::Operation::Filter, user_id: current_user.id do |result|
      @posts = result[:model].paginate(page: params[:page], per_page: 5)
      render :index
    end
  end

  # function: search
  # search post by keyword
  # @return [<Type>] <post>
  def search
    run Post::Operation::Search, current_user: current_user do |result|
      @posts = result[:model].paginate(page: params[:page], per_page: 5)
      @last_search_keyword = result[:last_search_keyword]
      render :index
      return
    end
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
    run Post::Operation::Create, current_user: current_user do |_|
      return redirect_to posts_path, notice: :POST_CREATED
    end
    render :new
  end

  # function: edit
  # show post edit form
  # params: id
  def edit
    run Post::Operation::Update::Present do |result|
      @post = result[:model]
    end
  end

  # function: update
  # update user
  # params: user, id
  def update
    run Post::Operation::Update, current_user: current_user do |result|
      return redirect_to post_path(result[:model]), notice: :POST_UPDATED
    end
    render :edit
  end

  # function: destroy
  # destroy post
  # params: id
  def destroy
    run Post::Operation::Destroy do |_|
      return redirect_to posts_path, notice: :POST_DELETED
    end
  end

  # functin upload_csv
  # show csv upload page
  # @return [<Type>] <description>
  def upload_csv
    :upload_csv_posts_path
  end

  # function download_csv
  # download post csv
  # @return [<Type>] <csv>
  def download_csv
    run Post::Operation::Export, current_user: current_user do |result|
      respond_to do |format|
        format.html
        format.csv { send_data result[:csv_data], :filename => "Posts-#{Date.today}.csv" }
      end
    end
  end

  # function csv_format
  # download csv format for upload
  # @return [<Type>] <description>
  def csv_format
    run Post::Operation::CsvFormat do |result|
      respond_to do |format|
        format.html
        format.csv { send_data result[:csv_format], :filename => "CSV Format.csv" }
      end
    end
  end

  # function import_csv
  # create posts by csv
  # @return [<Type>] <redirect>
  def import_csv
    run Post::Operation::Import, current_user_id: current_user.id do |_|
      return redirect_to posts_path, notice: Messages::UPLOAD_SUCCESSFUL
    end
    @errors = result["contract.default"].errors
    render :upload_csv
    return
  end
end
