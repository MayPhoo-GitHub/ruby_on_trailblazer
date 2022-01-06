# frozen_string_literal: true

class ApplicationController < ActionController::Base

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
      end
    
    def logged_in?
        !!current_user
      end
    
      def authorized?
        redirect_to login_path unless logged_in?
      end

      helper_method :current_user, :logged_in?
end
