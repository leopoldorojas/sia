class SalesController < ApplicationController
  def new
  	@share_operation = ShareOperation.new(operation_date: Time.zone.now)
  end
end
