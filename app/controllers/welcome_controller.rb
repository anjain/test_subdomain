class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  authorize_resource class: false, except: [:index]

  def index
  end

  def dashboard
  	if request.subdomain && request.subdomain == current_user.subdomain
  		@user = User.find_by(subdomain: request.subdomain)
  	else
  		flash[:error] = "Unathorized access"
  		redirect_to root_url
  	end
  end

  def seller_dashboard
  	dashboard
  end

  def buyer_dashboard
  	dashboard
  end

  def admin_dashboard
  	dashboard
  end

end
