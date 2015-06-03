class EndorsementsController < ApplicationController
  def search
  end

  def index
  end

  def new
  	@share_operation = ShareOperation.new(operation_date: Time.zone.now, shares_required: 0, cash: 0, dividends: 0, adjustment: 0)
  end

  def create
  end
end
