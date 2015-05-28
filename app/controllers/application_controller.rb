class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
        if resource.is_admin?
          admin_dashboard_path
        else
          dashboard_path
        end
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.present? && current_user.is_admin?
  end
end
