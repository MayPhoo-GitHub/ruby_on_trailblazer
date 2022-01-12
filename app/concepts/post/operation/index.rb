# frozen_string_literal: true

module Post::Operation
  class Index < Trailblazer::Operation
    step :get_posts

    def get_posts(options, **)
      current_user = options[:current_user]
      options["model"] = if current_user.super_user_flag == true
          Post.all.order("created_at DESC")
        else
          Post.where(public_flag: true).or(Post.where(created_user_id: current_user.id)).order("created_at DESC")
        end
    end
  end
end
