class IssuancesController < ApplicationController
  before_action :set_initial_share

  def new
  	@share_issue = ShareIssue.new(issue_date: Time.zone.now, initial_share: initial_share)
  end

  def create
    @share_issue = ShareIssue.new(share_issue_params)
    @share_issue.initial_share = initial_share
    @share_issue.initial_share.upto(@share_issue.final_share) { |number| @share_issue.shares.build(number: number) }

    respond_to do |format|
      if @share_issue.save
      	current_company.issued_shares_upto @share_issue.final_share

        format.html { redirect_to @share_issue, notice: 'Share issue was successfully created.' }
        format.json { render :show, status: :created, location: @share_issue }
      else
        format.html { render :new }
        format.json { render json: @share_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_initial_share
      @initial_share = current_company.last_share_issued + 1
    end

    def initial_share
      @initial_share
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_issue_params
      params.require(:share_issue).permit(:issue_date, :final_share, :company_id)
    end

end
