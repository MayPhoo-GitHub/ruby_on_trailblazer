module User::Operation
  class UpdateProfile < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::UpdateProfile)

      def model!(options, params:, **)
        options["model"] = User.find(options["user_id"])
      end
    end

    step Nested(Present)
    step Contract::Validate(key: :user)
    step Contract::Persist()
  end
end
