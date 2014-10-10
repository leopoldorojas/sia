class ShareIssuesController < ApplicationController
  before_action :set_share_issue, only: [:show, :edit, :update, :destroy]

  # GET /share_issues
  # GET /share_issues.json
  def index
    @share_issues = ShareIssue.all
  end

  # GET /share_issues/1
  # GET /share_issues/1.json
  def show
  end

  # GET /share_issues/new
  def new
    @share_issue = ShareIssue.new
  end

  # GET /share_issues/1/edit
  def edit
  end

  # POST /share_issues
  # POST /share_issues.json
  def create
    @share_issue = ShareIssue.new(share_issue_params)

    respond_to do |format|
      if @share_issue.save
        format.html { redirect_to @share_issue, notice: 'Share issue was successfully created.' }
        format.json { render :show, status: :created, location: @share_issue }
      else
        format.html { render :new }
        format.json { render json: @share_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /share_issues/1
  # PATCH/PUT /share_issues/1.json
  def update
    respond_to do |format|
      if @share_issue.update(share_issue_params)
        format.html { redirect_to @share_issue, notice: 'Share issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @share_issue }
      else
        format.html { render :edit }
        format.json { render json: @share_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /share_issues/1
  # DELETE /share_issues/1.json
  def destroy
    @share_issue.destroy
    respond_to do |format|
      format.html { redirect_to share_issues_url, notice: 'Share issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_issue
      @share_issue = ShareIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_issue_params
      params.require(:share_issue).permit(:issue_date, :initial_share, :final_share, :company_id)
    end
end
