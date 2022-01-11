require 'csv'
module Post::Operation
  class Export < Trailblazer::Operation
    step :get_posts
    step :to_csv

    def get_posts(options, **)
        current_user = options[:current_user]
        options[:model] = if current_user.super_user_flag == true
                             Post.all.order('created_at ASC')
                           else
                             Post.where(public_flag: true ).or(Post.where(created_user_id: current_user.id)).order('created_at ASC')
                           end
      end

    def to_csv(options, **)
        headers = Constants::POST_CSV_HEADER
        attributes = %w{id title description public_flag name}
        options[:csv_data] = CSV.generate(headers: true) do |csv|
                                csv << headers
                                options[:model].each do |post|
                                csv << [post.id,post.title,post.description,post.public_flag,post.user.name]
                                end
                            end
    end
  end
end
 