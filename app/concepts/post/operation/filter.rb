module Post::Operation
    class Filter < Trailblazer::Operation
        
        step :filter_posts

      def filter_posts(options,params:, **)
        options['model'] = Post.where(created_user_id: options[:user_id]).order('created_at DESC')
      end
    end
  end