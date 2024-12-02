class AdminController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is logged in
  before_action :authorize_admin!    # Ensure the user is an admin

  def dashboard
    # This is the admin-only dashboard
    # Add your admin-specific code here
  end

  private

  # Redirect to the homepage if a non-admin user tries to access this page
  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
