class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :require_login
  check_authorization unless: :devise_controller?


  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_back fallback_location: root_path, alert: "Sorry, you are not authorized to access that action or page. Please contact us to resolve this."
    else
      redirect_to new_user_session_path, alert: "Please login or create your account to continue."
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, roles: []]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource_or_scope)
   policies_due_today_path
  end

  def after_sign_out_path_for(resource_or_scope)
   new_user_session_path
  end
  # def require_login
  #   unless user_signed_in?
  #     flash[:error] = "You must be logged in to access this section"
  #     redirect_to new_user_path # halts request cycle
  #   end
  # end
end
