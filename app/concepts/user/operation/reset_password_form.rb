module User::Operation
  class ResetPasswordForm < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::ResetPasswordForm)

      def model!(options, params:, **)
        Rails.logger.info("optionsoptionsoptionsoptionsoptionsoptionsoptions")
        options["model"] = User.find_signed(params[:token], purpose: "password_reset")
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        false
        options["token"] = params[:token]
      end
    end

    step Subprocess(Present)
    step Contract::Validate(key: :user)
    step Contract::Persist()
  end
end
