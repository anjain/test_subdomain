class ApplicationController < ActionController::Base
  include UrlHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :subdomain, :role) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password, :subdomain, :role)
    end
  end

  def after_sign_in_path_for(resource)
    after_signup_path_for(resource) 	
  end

  def after_signup_path_for(resource)
  	if resource.has_role? :admin
      admin_dashboard_url(subdomain: resource.subdomain)
    elsif resource.has_role? :seller
      seller_dashboard_url(subdomain: resource.subdomain)
    elsif resource.has_role? :buyer
      buyer_dashboard_url(subdomain: resource.subdomain)
    end
  end

end
