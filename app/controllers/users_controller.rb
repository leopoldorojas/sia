class UsersController < ApplicationController
  before_action :set_user, except: :index
  before_action :authorize_for_managing

  def index
    if params[:approved] == "false"
      @users = policy_scope(User).find_all_by_approved(false)
    else
      @users = policy_scope(User)
    end
  end

  def edit
    @roles = roles
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: t('user.updated') }
        format.json { render :show, status: :ok, location: @user }
      else
        @roles = roles
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('user.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def roles
      user_roles = current_user.is?(:superadmin) ? Rails.application.config.user_roles : Rails.application.config.user_roles.reject {|key, value| key == :superadmin }
      user_roles.keys.map { |role| [t("user.roles.#{role}"), role] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :company_id, :approved, :role)
    end

    def authorize_for_managing
     authorize User, :manage?
    end
end
