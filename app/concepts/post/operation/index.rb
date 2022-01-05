# frozen_string_literal: true

module Post::Operation
    class Index < Trailblazer::Operation
      step :get_posts

      def get_posts(options, **)
        options['model'] = Post.all
      end
    end
  end
  
