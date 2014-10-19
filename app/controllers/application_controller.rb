class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_company

  I18n.locale = :es

  private 

	  def set_current_company
	  	@company = Company.first_or_create(name: "EDESA")
	  end

end
