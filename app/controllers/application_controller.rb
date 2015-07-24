class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :set_current_company
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  I18n.locale = :es

  private 

	  def set_current_company
	  	@company = Company.get
	  end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :company_id]
    end

    def user_not_authorized
      render plain: t(:unauthorized), status: 401
    end

end
