class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_company

  I18n.locale = :es

  def current_company
  	@company
  end

  private 

	  def set_current_company
	  	@company = Company.new(last_share_issued: 0)
	  end

end
