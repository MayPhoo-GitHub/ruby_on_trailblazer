# frozen_string_literal: true

module User::Operation
  class Index < Trailblazer::Operation
    step :get_users

    def get_users(options, **)
      options["model"] = User.all
    end
  end
end
