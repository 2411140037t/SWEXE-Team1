class Staff::BaseController < ApplicationController
  before_action :require_staff

  private

  def require_staff
    redirect_to login_path unless current_user&.staff?
  end
end
