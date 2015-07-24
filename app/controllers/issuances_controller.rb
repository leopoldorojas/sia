class IssuancesController < ApplicationController
  before_action :set_initial_share
  before_action :authorize_for_managing, except: [:index, :search, :show]

  def search
    @share_issues = RealIssue.all
    @share_issues = @share_issues.since(params[:start_date]) if params[:start_date].present?
    @share_issues = @share_issues.until(params[:end_date]) if params[:end_date].present?
    @share_issues = @share_issues.includes(:share_type).where(share_types: {identifier: params[:share_type]}) if params[:share_type].present?
    @share_issues = @share_issues.between(params[:initial_share], params[:final_share]) if params[:initial_share].present? || params[:final_share].present?
    respond_to :json
  end

  def new
  	@share_issue = RealIssue.new(issue_date: Time.zone.now, initial_share: initial_share, final_share: initial_share)
  end

  def create
    @share_issue = RealIssue.new(share_issue_params)
    @share_issue.initial_share = initial_share

    respond_to do |format|
      if @share_issue.save
        format.html { redirect_to share_issue_path(@share_issue), notice: t('issuance.created') }
        format.json { render :show, status: :created, location: @share_issue }
      else
        format.html { render :new }
        format.json { render json: @share_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_initial_share
      @initial_share = current_company.last_share_issued.to_i + 1
    end

    def initial_share
      @initial_share
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_issue_params
      params.require(:real_issue).permit(:issue_date, :initial_share, :final_share, :share_type_id)
    end

    def authorize_for_managing
     authorize ShareIssue, :manage?
    end
end
