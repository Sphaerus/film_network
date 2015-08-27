class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  add_crumb("Home") { |instance| instance.send :root_path }
  protect_from_forgery with: :exception
  
  rescue_from "Pundit::NotAuthorizedError", with: :not_authorized
  
  private
  
  def not_authorized
    respond_to do |format|
      if current_user
        redirect_to root_path notice: "You are not authorized to perform this action."
      else
        redirect_to new_user_session_path, notice: "Log in to perform this action."
      end
    end
  end
end
