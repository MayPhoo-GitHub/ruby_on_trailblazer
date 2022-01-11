module Post::Operation
    class Search < Trailblazer::Operation
      step :search_posts!

      def search_posts!(options, params:, **)
        current_user = options[:current_user]
        options['model'] = if current_user.super_user_flag == true
                             Post.all.order('created_at DESC')
                           else
                             Post.where(public_flag: true ).or(Post.where(created_user_id: current_user.id)).order('created_at DESC')
                           end
        options[:model] = options['model'] .where("title LIKE :title or description LIKE :desc", {:title => "%#{params[:search_keyword]}%", :desc => "%#{params[:search_keyword]}%"})
        options[:last_search_keyword] = params[:search_keyword]
      end
  end
end
