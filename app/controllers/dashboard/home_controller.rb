class Dashboard::HomeController < Dashboard::DashboardController
  def index
    @events = current_user.events
  end
end
