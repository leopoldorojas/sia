class IssuancesController < ApplicationController
  def new
  	@share_issue = ShareIssue.new(issue_date: Time.zone.now)
  end

  def create
  end
end
