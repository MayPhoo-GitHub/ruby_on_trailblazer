class PostService
  class << self

    # function getAllPosts
    # get posts
    # @return @posts
    def getAllPosts(current_user)
      @posts = PostRepository.getAllPosts(current_user)
    end

    # function getPostById
    # @param [<int>] id
    # @return [<Type>] post
    def getPostById(id)
      @post = PostRepository.getPostById(id)
    end

    # function create post
    # @param [<Type>] post <description>
    # @return [<Type>] is_save_post
    def createPost(post)
      @is_save_post = PostRepository.createPost(post)
    end

    # function : updatePost
    # @param [<Type>] post <description>
    # @param [<Type>] post_params <description>
    # @return [<Type>] is_update_post
    def updatePost(post, post_params)
      @is_update_post = PostRepository.updatePost(post, post_params)
    end

    # function : destroyPost
    # delete post
    # @param [<Type>] post <description>
    # @return [<Type>] <description>
    def destroyPost(post)
      PostRepository.destroyPost(post)
    end

    # function :search
    # search post
    # @param [<Type>] search_keyword <description>
    # @return [<Type>] <posts>
    def search(search_keyword, current_user)
      @posts = PostRepository.search(search_keyword, current_user)
    end

    # function :filter
    # filter posts
    # @param [<Type>] filter_by <description>
    # @param [<Type>] user_id <description>
    # @return [<Type>] <posts>
    def filter(user_id)
      @posts = PostRepository.filter(user_id)
    end
  end
end
