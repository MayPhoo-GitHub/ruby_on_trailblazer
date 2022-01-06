module User::Operation
    class Show < Trailblazer::Operation
      class Present < Trailblazer::Operation
        step Model(User, :find_by)
      end
    end
  end