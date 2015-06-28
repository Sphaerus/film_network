class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  
  rescue_from "Pundit::NotAuthorizedError", with: :not_authorized
  
  private
  
  def not_authorized
    render plain: "You are not authorized to perform this task"
  end
end
