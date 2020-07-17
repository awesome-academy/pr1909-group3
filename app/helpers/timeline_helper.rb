module TimelineHelper
  def dashboard_timeline_el element
    name_el = element.class.name.downcase
    render "dashboard/timeline/" + element.class.name.downcase, "#{name_el}": element
  end

  def timeline_el element
    name_el = element.class.name.downcase
    render "timeline/" + element.class.name.downcase, "#{name_el}": element
  end
end
