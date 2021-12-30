class PostsController < ApplicationController
  before_action :authorized?

  def index
    @posts = PostService.getAllPosts(current_user).paginate(page: params[:page], per_page: 5)
  end

  # function : show
  # show post
  # param : post_id
  # @return [<Type>] <post>
  def show
    @post = PostService.getPostById(params[:id])
  end

  # function : new
  # show create post
  # @return [<Type>] <post>
  def new
    @post = Post.new
    # logger.info(@post)
  end

  # function : create
  # param : post_params
  # create post
  # @return redirect
  def new_post
    params[:post][:created_user_id] ||= current_user.id
    @post = Post.new(post_params)
    @is_save_post = PostService.createPost(@post)
    if @is_save_post
      redirect_to posts_path
    else
      render :new
    end
  end

  # function : edit
  # param : post_id
  # show edit post
  # @return [<Type>] <post>
  def edit
    @post = PostService.getPostById(params[:id])
    if @post.created_user_id != current_user.id && current_user.super_user_flag != true
      redirect_to posts_path
    end
  end

  # function : update
  # param : post_id, post_params
  # @return [<Type>] redirect
  def update
    @post = PostService.getPostById(params[:id])
    params[:post][:updated_user_id] = current_user.id
    @is_post_update = PostService.updatePost(@post, post_params)
    if @is_post_update
      redirect_to posts_path
    else
      render :edit
    end
  end

  # function : destory
  # delete post
  # param : post_id
  # @return [<Type>] redirect
  def destroy
    @post = PostService.getPostById(params[:id])
    PostService.destroyPost(@post)
    redirect_to posts_path
  end

  # function :search
  # search posts
  # @return [<Type>] <posts>
  def search
    @search_keyword = params[:search_keyword]
    @posts = PostService.search(@search_keyword, current_user).paginate(page: params[:page], per_page: 5)
    @last_search_keyword = @search_keyword
    render :index
  end

  # function filter
  # filter posts
  # param : filter_by
  # @return [<Type>] <posts>
  def filter
    @user_id = current_user.id
    @posts = PostService.filter(@user_id).paginate(page: params[:page], per_page: 5)
    render :index
  end

  # function download_csv
  # download post csv
  #
  # @return [<Type>] <csv>
  def download_csv
    @posts = PostService.getAllPosts(current_user)
    @posts = @posts.reorder("id ASC")
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv, :filename => "Posts-#{Date.today}.csv" }
    end
  end

  # functin upload_csv
  # show csv upload page
  # @return [<Type>] <description>
  def upload_csv
    :upload_csv_posts_path
  end

  # function import_csv
  # create posts by csv
  # @return [<Type>] <redirect>
  def import_csv
    if (params[:file].nil?)
      redirect_to upload_csv_posts_path, notice: :CSV_FILE_IS_REQUIRED
    elsif !File.extname(params[:file]).eql?(".csv")
      redirect_to upload_csv_posts_path, notice: :WRONG_FILE_TYPE
    else
      error = PostsHelper.check_header(Constants::POST_CSV_FORMAT_HEADER, params[:file])
      if error.present?
        redirect_to upload_csv_posts_path, notice: error
      else
        file_result = Post.import(params[:file], current_user.id)
        if (file_result == true)
          redirect_to posts_path, notice: :FILE_UPLOADED_SUCCESSFULLY
        else
          redirect_to upload_csv_posts_path, notice: file_result
        end
      end
    end
  end

  # function csv_format
  # download csv format for upload
  # @return [<Type>] <description>
  def csv_format
    @post = Post.new
    respond_to do |format|
      format.html
      format.csv { send_data @post.csv_format, :filename => "CSV Format.csv" }
    end
  end

  private

  # set post parameters
  # @return [<Type>] <description>
  def post_params
    params.require(:post).permit(:title, :description, :public_flag, :created_user_id, :updated_user_id)
  end
end
