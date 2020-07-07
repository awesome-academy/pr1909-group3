class Dashboard::HomeController < Dashboard::DashboardController
  def index
    byebug
    @events = current_user.events
  end
end
