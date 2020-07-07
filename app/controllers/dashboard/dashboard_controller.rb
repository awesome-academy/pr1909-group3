class Dashboard::DashboardController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  byebug
  layout 'dashboard/application'

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path
    end
  end
end
