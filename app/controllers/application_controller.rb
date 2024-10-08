class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  set_current_tenant_by_subdomain(:organisation, :subdomain)
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pagy::Backend

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, owned_organisation_attributes: [:name, :subdomain]])
  end

  def authenticate_owner!
    unless current_user.organisation_owner?
      flash[:alert] = "You're not authorized..!!"
      redirect_back_or_to(root_path)
    end
  end

  def authenticate_owner_or_team_leader!
    unless current_user.organisation_owner? || current_user.has_role?(:team_leader)
      flash[:alert] = "You're not authorized..!!"
      redirect_back_or_to(root_path)
    end
  end

  def after_sign_in_path_for(resource)
    if resource.organisation_owner?
      dashboard_index_url(subdomain: resource.owned_organisation.subdomain)
    elsif resource.admin?
      admin_dashboard_index_url
    else
      dashboard_index_url(subdomain: resource.organisation.subdomain)
    end
  end
end
