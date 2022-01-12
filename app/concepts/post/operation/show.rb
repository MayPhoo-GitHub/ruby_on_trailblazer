module Post::Operation
  class Show < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :find_by)
    end
  end
end
