class PasswordResetsController < ApplicationController
  def new
    render :new
  end

  def create
    run User::Operation::ResetPassword do |result|
      return redirect_to root_path, notice: "We have sent a link to reset a password."
    end
    if result.failure?
      if result[:fail]
        redirect_to reset_password_path, notice: "No account with this email exists."
      else
        redirect_to reset_password_path, notice: "Something went wrong."
      end
    end
  end

  def edit
    run User::Operation::ResetPasswordForm::Present do |result|
      render :edit
    end
    if result.failure?
      redirect_to root_path, notice: "Your token has expired."
    end
  end

  def update
    run User::Operation::ResetPasswordForm do |result|
      return redirect_to root_path, notice: "Your password has been changed."
    end
    render :edit
  end
end
