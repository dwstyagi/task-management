class Admin::DashboardController < ApplicationController
  def index
    @organisation = Organisation.all
  end
end
