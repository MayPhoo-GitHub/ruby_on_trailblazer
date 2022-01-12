module Post::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
    end

    step Nested(Present)
    step :created_user!
    step Contract::Validate(key: :post)
    step Contract::Persist()

    def created_user!(options, **)
      options[:params][:post][:created_user_id] = options["current_user"][:id]
    end
  end
end
