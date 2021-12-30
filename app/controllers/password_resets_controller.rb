class PasswordResetsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      #send email
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to password_reset_path, notice: "We will send a password reset link to your email if your account really exist."
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to password_reset_path, notice: "Your token has expired, reset again"
  end

  def update
    if password_params[:password].blank? && password_params[:password_confirmation].blank?
      redirect_to password_reset_edit_path(token: params[:token]), notice: :PASSWORD_REQUIRE_VALIDATION
    elsif password_params[:password].blank? && password_params[:password_confirmation] != nil
      redirect_to password_reset_edit_path(token: params[:token]), notice: :PASSWORD_REQUIRE_VALIDATION
    elsif password_params[:password] != nil && password_params[:password_confirmation].blank?
      redirect_to password_reset_edit_path(token: params[:token]), notice: :PASSWORD_CONFIRMATION_REQUIRED
    elsif password_params[:password] != password_params[:password_confirmation]
      redirect_to password_reset_edit_path(token: params[:token]), notice: :PASSWORD_AND_CONFIRM_PASSWORD_NOT_SAME
    elsif password_params[:password].length < 8
      redirect_to password_reset_edit_path(token: params[:token]), notice: :Password_Is_Too_Short
    else
      @user = User.find_signed(params[:token], purpose: "password_reset")
      if @user.update(password_params)
        redirect_to login_path, notice: "Password reset successfully, please log in again"
      end
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
