class Dashboard::HomesController < Dashboard::DashboardController
  def index
    @events = current_user.events
  end
end
