class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to plans_path, :notice => exception.message
  end
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    plans_path
  end
  def current_ability
    @current_ability ||= Ability.new(current_user,params)
  end
end
