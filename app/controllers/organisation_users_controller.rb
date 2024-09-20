class OrganisationUsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  def index
    @users = current_tenant.users
  end

  def change_role
    @user = current_tenant.users.find(params[:id])
    if @user.roles.any?
      roles = @user.roles.pluck(:name)
      roles.map { |role| @user.remove_role(role) }
    end
    @user.add_role(params[:role])
    redirect_to organisation_users_path, notice: "Role Updated..!!"
  end
end
