class Dashboard::HomeController < Dashboard::DashboardController
  def index
    @events = current_user.events
  end

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path
    end
  end
end
