class IssuancesController < ApplicationController
  def new
  	@share_issue = ShareIssue.new
  end
end
